# CombinePopoloMemberships

Combine overlapping Popolo Term and Party memberships.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'combine_popolo_memberships'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install combine_popolo_memberships

## Usage

```ruby
term_mems = [
  { id: '2', name: '2. Národná rada 1998-2002', start_date: '1998-09-26', end_date: '2002-09-21' }
]

group_mems = [
  { name: 'Independent', id: '0', end_date: Date.new(1998, 10, 28) },
  { id: '1', name: 'Klub ĽS-HZDS', start_date: Date.new(1998, 10, 29), end_date: Date.new(2002, 07, 15) },
  { name: 'Independent', id: '0', start_date: Date.new(2002, 07, 16) }
]

output = CombinePopoloMemberships.combine(term: term_mems, faction_id: group_mems)

output == [
  { start_date: '1998-09-26', end_date: '1998-10-28', faction_id: '0', term: '2' },
  { start_date: '1998-10-29', end_date: '2002-07-15', faction_id: '1', term: '2' },
  { start_date: '2002-07-16', end_date: '2002-09-21', faction_id: '0', term: '2' }
] # => true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/everypolitician/combine_popolo_memberships.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
