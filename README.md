# Slovom [![Build Status](https://secure.travis-ci.org/tarakanbg/slovom.png)](http://travis-ci.org/tarakanbg/slovom)

A Ruby gem which converts decimal currency numbers into text in Bulgarian language. For use in financial applications, accounting documents, and all other instances requiring currency verbalization.

Handles the specifics of verbally presenting numbers and prices in Bulgarian, including grammatical irregularities, differences due to gender, singularity and plurality and the logic of using or omitting the "and" conjunction from the resulting string.

## Installation

Add this line to your application's Gemfile:

    gem 'slovom'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slovom

## Usage

Just append the `.slovom` method to the decimal (variable) you want to be presented verbally.

This will return a text string with the currency ammount (in levs) expressed verbally.

```ruby
product1.price.to_s => "23.00"
product1.price.slovom => "двадесет и три лева"

product2.price.to_s => "1563.78"
product2.price.slovom => "хиляда петстотин шестдесет и три лева и седемдесет и осем стотинки"

product3.price.to_s => "0.75"
product3.price.slovom => "седемдесет и пет стотинки"
```

It parses numbers of up to 1 quadrillion (1000000000000000), as higher numbers are not likely to be used in financial transactions and hence no need to be expressed verbally. It returns the string "много" if higher number is used.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
