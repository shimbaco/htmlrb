# Htmlrb

A DSL for building HTML programmatically.


## Installation

Add this line to your application's Gemfile:

```ruby
gem "htmlrb"
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install htmlrb
```


## Usage

```ruby
html = Htmlrb.build do |h|
  h.tag :a, href: "http://yurucamp.jp", class: "Yuru Camp△", target: "_blank" do
    h.text "Yuru Camp△"
  end
end

puts html #=> <a href="http://yurucamp.jp" class="Yuru Camp△" target="_blank">Yuru Camp△</a>
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kiraka/htmlrb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


## Code of Conduct

Everyone interacting in the Htmlrb project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kiraka/htmlrb/blob/main/CODE_OF_CONDUCT.md).


## Credits

The gem is inspired by the [crystal-lang/html_builder](https://github.com/crystal-lang/html_builder).
