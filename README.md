# Doll

The Chatbot Framework written in Ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'doll'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install doll

## Usage

Requirement:

* puma

Prepare your Rack (`config.ru`)
```ruby
require 'doll'

require './config'
require './converse'

run Doll.server
```

Configure your chatbot (`config.rb`)
```ruby
Doll.configure do
  # Support Adapters
  adapter Doll::Adapter::Plain.new
  adapter Doll::Adapter::Facebook.new(
    'ACCESS_TOKEN',
    'SECRET_TOKEN',
    'VERIFY_TOKEN'
  )
end
```

Configure your chatbot converse rules (`converse.rb`)
```ruby
Doll.converse do
  # TODO: Keyword matcher is comming soon...
  not_found { 'I cannot figure out what you say....' }
end
```

Create your dialog classes
TODO: Add support for dialog

Start your server
```bash
$ puma -C config.ru
```

Now, you can access your chatbot via `https://example.com/facebook`

## Development

TODO: Write development guide

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elct9620/doll.

