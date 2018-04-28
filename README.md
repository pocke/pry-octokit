# pry-octokit

Call GitHub API from Pry.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pry-octokit'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pry-octokit

## Usage

You can use `gh/` command to call GitHub API. It receives a path of API URL.

```ruby
[1] pry(main)> gh/user
=> {:login=>"pocke",
 :id=>4361134,
 :avatar_url=>"https://avatars0.githubusercontent.com/u/4361134?v=4",
 :gravatar_id=>"",
 :url=>"https://api.github.com/users/pocke",
 :html_url=>"https://github.com/pocke",
 :followers_url=>"https://api.github.com/users/pocke/followers",
 (snip)

[2] pry(main)> _ # You can access the last response from the `_` variable.
 (snip)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/pocke/pry-octokit.
