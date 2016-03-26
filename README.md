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

This function takes two hashes of parallel membership lists (e.g.
membership of a Legislature, and memberships of a political
party/faction), and returns a single list of all the membership
permuations.  Each must contain an `id`, and in the resulting hash the
value of that key will be set according to the instructions given (e.g.
in the example below the `id` of the `term_mems` will be set as `term`
in the result)

```ruby

term_mems = [
  { id: '1', start_date: '1998-01-01', end_date: '1999-12-31', area: 'Oldville' },
  { id: '2', start_date: '2000-01-01', end_date: '2001-12-31', area: 'Newville' }
]

group_mems = [
  { id: 'White Party', start_date: '1990-01-01', end_date: '1999-05-28' },
  { id: 'Black Party', start_date: '1999-06-01' },
]

output = CombinePopoloMemberships.combine(term: term_mems, faction_id: group_mems)

output == [
  { start_date: "1998-01-01", end_date: "1999-05-28", faction: "White Party", term: "1"},
  { start_date: "1999-06-01", end_date: "1999-12-31", faction: "Black Party", term: "1"},
  { start_date: "2000-01-01", end_date: "2001-12-31", faction: "Black Party", term: "2"}
] # => true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake test` to run the tests. You can also run `bin/console`
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake
install`. To release a new version, update the version number in
`version.rb`, and then run `bundle exec rake release`, which will create
a git tag for the version, push git commits and tags, and push the
`.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/everypolitician/combine_popolo_memberships.

## License

The gem is available under the terms of the [MIT License](http://opensource.org/licenses/MIT).

