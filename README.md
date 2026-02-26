# 🏺 Potter

A gem for modeling anything: databases, CSVs, REST APIs, file systems.

It's meant to be simple and compact.

## 💎 Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add potter
```

If bundler is not being used to manage dependencies, install the gem by
executing:

```bash
gem install potter
```

## Usage

Start by declaring your models:

```rb
class Base
  include Potter::API
  root "https://"
end

class Transaction < Base
  date       :date
  belongs_to :merchant
  string  :category
  string  :account
  string  :original_statement
  string  :notes
  float   :amount, scale: 2, note: "positive numbers for income and negative numbers for expenses"
  string  :tags
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/craft-concept/potter.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).
