# frozen_string_literal: true

require "net/http"
require "fea/authentication"

RSpec.describe Fea::Authentication do
  subject(:authn) do
    described_class.new(username, password, portal_path: portal_path)
  end

  let(:username) { "foo" }
  let(:password) { "bar" }
  let(:portal_path) { "/bonita" }

  let(:http) do
    instance_double(Net::HTTP, address: "bonita", port: "80")
  end

  def stub_response(head, allow_body: true)
    io = StringIO.new(head)
    socket = Net::BufferedIO.new(io)
    response = Net::HTTPResponse.read_new(socket)
    response.reading_body(socket, allow_body) {} # rubocop:disable Lint/EmptyBlock
    response
  end

  def a_login_request
    a_kind_of(Net::HTTP::Post) & an_object_having_attributes(
      path: "/bonita/loginservice",
      content_type: "application/x-www-form-urlencoded",
      body: URI.encode_www_form(
        "username" => username,
        "password" => password,
        "redirect" => "false"
      )
    )
  end

  def a_successful_login_response
    stub_response(<<~HTTP)
      HTTP/1.1 200 OK
      Content-Length: 0
      Date: Sun, 07 Jul 2019 09:34:41 GMT
      Set-Cookie: bonita.tenant=1
      Set-Cookie: JSESSIONID=ABA966CB51E50E45CE0CC84560FF3428; Path=/bonita; HttpOnly
      Set-Cookie: X-Bonita-API-Token=24d2b188-5948-4b43-bd88-7c4930666de0; Path=/bonita
      Content-Type: text/plain; charset=utf-8
    HTTP
  end

  def a_logout_request
    a_kind_of(Net::HTTP::Get) & an_object_having_attributes(
      path: "/bonita/logoutservice?redirect=false",
      content_type: "text/plain",
      to_hash: a_hash_including(
        "cookie" => ["bonita.tenant=1; JSESSIONID=ABA966CB51E50E45CE0CC84560FF3428"]
      )
    )
  end

  def a_succesful_logout_response
    stub_response(<<~HTTP)
      HTTP/1.1 200 OK
      Content-Length: 0
      Date: Sun, 07 Jul 2019 10:17:49 GMT
      Set-Cookie: JSESSIONID=19A913F36D58469948497B3680E7196F; Path=/bonita; HttpOnly
      Content-Type: text/plain; charset=utf-8
    HTTP
  end

  def an_unauthorized_response
    stub_response(<<~HTTP)
      HTTP/1.1 401 Unauthorized
      Content-Length: 0
      Date: Sun, 07 Jul 2019 09:48:11 GMT
      Content-Type: text/plain; charset=utf-8
    HTTP
  end

  def a_server_error_response
    stub_response(<<~HTTP)
      HTTP/1.1 500 Internal Server Error
      Content-Length: 0
      Date: Sun, 07 Jul 2019 09:48:11 GMT
      Content-Type: text/plain; charset=utf-8
    HTTP
  end

  def stub_login_request(response)
    allow(http).to receive(:request)
      .with(a_login_request)
      .and_return(response)
  end

  def stub_logout_request(response)
    allow(http).to receive(:request)
      .with(a_logout_request)
      .and_return(response)
  end

  def successfully_login
    stub_login_request(a_successful_login_response)
    authn.login(http)
  end

  describe "#login" do
    it "can login successfully" do
      successfully_login
      expect(authn).to be_logged_in
    end

    it "handles login failures" do
      stub_login_request(an_unauthorized_response)

      expect { authn.login(http) }.to raise_error(
        Fea::AuthenticationError, "Invalid username/password ?"
      )

      expect(authn).not_to be_logged_in
    end

    it "handles random failures" do
      stub_login_request(a_server_error_response)

      expect { authn.login(http) }.to raise_error(
        Fea::ResponseError, /InternalServerError/
      )

      expect(authn).not_to be_logged_in
    end
  end

  describe "#logged_in?" do
    it "is false by default" do
      expect(authn).not_to be_logged_in
    end

    it "is true when logged in" do
      successfully_login

      expect(authn).to be_logged_in
    end
  end

  describe "#logout" do
    it "cannot logout unless logged in" do
      expect { authn.logout(http) }.to raise_error(Fea::NotAuthenticatedError)
    end

    context "when logged in" do
      before { successfully_login }

      it "can logout" do
        stub_logout_request(a_succesful_logout_response)

        authn.logout(http)

        expect(authn).not_to be_logged_in
      end

      it "handles random failures" do
        stub_logout_request(a_server_error_response)

        expect { authn.logout(http) }.to raise_error(Fea::ResponseError, /InternalServerError/)

        expect(authn).to be_logged_in
      end
    end
  end

  describe "#apply" do
    let(:req) { Net::HTTP::Get.new("foo") }

    it "cannot apply authentication unless logged in" do
      expect { authn.apply(req) }.to raise_error(Fea::NotAuthenticatedError)
    end

    it "can apply authentication if logged in" do
      successfully_login

      authn.apply(req)

      expect(req["x-bonita-api-token"]).to eq("24d2b188-5948-4b43-bd88-7c4930666de0")
      expect(req["cookie"]).to eq("bonita.tenant=1; JSESSIONID=ABA966CB51E50E45CE0CC84560FF3428")
    end
  end

  describe "#purge" do
    let(:req) { Net::HTTP::Get.new("foo") }

    it "cannot purge authentication unless logged in" do
      expect { authn.purge(req) }.to raise_error(Fea::NotAuthenticatedError)
    end

    it "can apply authentication if logged in" do
      successfully_login

      authn.purge(req)

      expect(req["x-bonita-api-token"]).to eq("HIDDEN")
      expect(req["cookie"]).to eq("HIDDEN")
    end
  end
end
