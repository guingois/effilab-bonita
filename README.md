# Fea

Fea is a Ruby client for the REST API of Bonita BPM Platform.

The library was last tested using [Bonita BPM Platform
7.4](https://documentation.bonitasoft.com/bonita/0/archives#_bonita_bpm_7_3_to_bonita_bpm_7_5).

Even though the library itself is rather generic and might be compatible
with later versions of Bonita, **those are not officially supported**.
Contributions are welcome to provide support for up to date versions of
Bonita.


## Installation

This gem is not published on RubyGems, and one could instead rely on
Bundler's ability to [install gems from git
repositories](https://bundler.io/guides/git.html) to use it.

## Usage

Please generate the documentation website using `bundle exec yard doc`
and visit `doc/yard/index.html` for details on how to use the library.

## Development

After checking out the repo, run `bundle install` to install
dependencies. Then, run `bundle exec rspec` to run the tests.

Before committing changes to the library, please run `bundle exec
rubocop` to make sure your changes satisfy the Rubocop config
requirements.

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/guingois/fea.

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).
