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

## Usage

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

1. [Fork it](https://github.com/andrewmcodes/consolidated_screening_list/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Attribution

This gem was originally forked from [benbalter/import_export](https://github.com/benbalter/import_export).
