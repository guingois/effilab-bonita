# BonitaBPM Ruby API Client

Unofficial API client for [Bonita API](https://effilab.atlassian.net/wiki/display/IT/Product+Launch+-+Overview)

The exhaustive list of all covered endpoints can be found [here](endpoints.md). It is still far from covering all of them but it provides a good structure to build

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bonita'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bonita

## Usage

### Client instantiation

Bonita API requires you to login to the portal URL, then logout when you're done.

There is two way to handle this authentication logic.

#### With a block

```ruby
Bonita::Client.start(username: "YOUR_USERNAME", password: "YOUR_PASSWORD", url: "YOUR_BONITA_SERVER_URL") do |client|
  # Perform your request while authenticated using the client object
end # Logout seamlessly when closing the block_given
```

#### With an instance
```ruby
client = Bonita::Client.new(username: "YOUR_USERNAME", password: "YOUR_PASSWORD", url: "YOUR_BONITA_SERVER_URL")
client.login
# perform request
client.logout
```

### Practical usage

Using the `client` object instantiated above, call the method corresponding to the API you want to request, then call the resource, then the action.

```ruby
# Find a case
client.bpm.cases.find(caseId: 123)
# => #<Bonita::Bpm::Case @id=123, ...>

# Create a case
new_case = Bonita::Bpm::Case.new(processDefinitionId: 123, variables: [{ foo: "bar" }])
client.bpm.cases.create(new_case)
# => #<Bonita::Bpm::Case @id=123, ...>

# Search for a case
# For more details about how search works, check out the corresponding article on the official Bonita API documentation.
client.bpm.cases.search(
  c: 10, # number of results,
  p: 2, # index of the page to display
  s: "a name", # search criteria
  o: "name", # order
  d: %w(processDefinitionId started_by), # extend resource response
  f: "activationState=DISABLED" # search filter
)
# => [#<Bonita::Bpm::Case @id=123, ...>, #<Bonita::Bpm::Case @id=123, ...>]

# Delete a case
client.bpm.cases.delete(caseId: 123)
# => true

# Retrieve a case context
client.bpm.cases.context(caseId: 123)
# => #<Hash>
```

Checkout `lib/mappings` for a list of existing methods

# Todo

- Do not use /bonita as a base URL. 
- Remove Kartograph dependency and return plain hashes. (to be debated)
- Real life tests
- Cover more endpoints


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Effilab/bonita. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
