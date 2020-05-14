# ConsolidatedScreeningList

[![Gem Version](https://badge.fury.io/rb/consolidated_screening_list.svg)][gem]
[![Maintainability](https://api.codeclimate.com/v1/badges/a3879f6457471eb95618/maintainability)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/github/andrewmcodes/consolidated_screening_list/badge.svg)][coverage]
[![Test Coverage](https://api.codeclimate.com/v1/badges/a3879f6457471eb95618/test_coverage)][coverage]
[![Inline docs](http://inch-ci.org/github/andrewmcodes/consolidated_screening_list.svg?branch=master)][inchpages]
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)][projectstatus]
![StandardRB](https://github.com/andrewmcodes/consolidated_screening_list/workflows/StandardRB/badge.svg)
![Tests](https://github.com/andrewmcodes/consolidated_screening_list/workflows/Tests/badge.svg)
![Yardstick](https://github.com/andrewmcodes/consolidated_screening_list/workflows/Yardstick/badge.svg)

[gem]: http://badge.fury.io/rb/consolidated_screening_list
[travis]: http://travis-ci.org/andrewmcodes/consolidated_screening_list
[codeclimate]: https://codeclimate.com/github/andrewmcodes/consolidated_screening_list/maintainability
[coverage]: https://coveralls.io/github/andrewmcodes/consolidated_screening_list
[inchpages]: http://inch-ci.org/github/andrewmcodes/consolidated_screening_list
[projectstatus]: https://www.repostatus.org/#active


A Ruby client for [Trade.gov's Consolidated Screening List](https://developer.trade.gov/consolidated-screening-list.html)


## Attribution

This gem was originally forked from [benbalter/import_export](https://github.com/benbalter/import_export).

## Installation

Adding to a gem:

```ruby
# my-cool-gem.gemspec
Gem::Specification.new do |spec|
  # ...
  spec.add_dependency "consolidated_screening_list", "~> 0.0.2"
  # ...
end
```

Or adding to your project:

```ruby
# Gemfile
gem "consolidated_screening_list", "~> 0.0.2"
```

### Supported Ruby versions

- Ruby (MRI) >= 2.3.0
<!-- - JRuby >= 9.2.9 -->

## Usage

:warning: These are incomplete

```sh
client = ImportExport::Client.new :api_key => "12345"
client.search :q => "smith"
=> [
  #<ImportExport::Result name="PRIDMORE-SMITH, BRAMWELL J.">,
  #<ImportExport::Result name="PRIDMORE-SMITH, JOHN B.">
]

client.search :name => "smith", :fuzzy_name => true
=> [
  #<ImportExport::Result name="PRIDMORE-SMITH, JOHN B.">,
  #<ImportExport::Result name="PRIDMORE-SMITH, BRAMWELL J.">,
  #<ImportExport::Result name="MID-SOUTH INVESTMENTS LIMITED">,
  #<ImportExport::Result name="SOUTH-EAST MOVEMENT">,
  ...
]
```

### Available parameters

* `q`
* `sources`
* `countries` (defaults to all countries)
* `address`
* `name`
* `fuzzy_name` (true or false)
* `type`
* `size` (number of results per page, defaults to 100)
* `offset` (defaults to 0)

For more information, see [the Consolidated Screening List API docs](https://developer.trade.gov/consolidated-screening-list.html).

### Command line usage

```sh
consolidated_screening_list [NAME]
```

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/andrewmcodes/consolidated_screening_list](https://github.com/andrewmcodes/consolidated_screening_list).

### Commit message

This project will be following [Coventional Commits v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/) moving forward.


The commit message should be structured as follows:

```sh
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

Valid types:

- build
- ci
- chore
- docs
- feat
- fix
- perf
- refactor
- revert
- style
- test

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
