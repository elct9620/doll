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

  # NLP Support
  use Doll::NLP::Wit.new('API_TOKEN')
end
```

Configure your chatbot converse rules (`converse.rb`)
```ruby
Doll.converse do
  match /[Hh]ello/, to: :hello
  # Current only support `intent` as predict entity for Wit.ai
  intent :buy

  not_found { 'I cannot figure out what you say....' }
end
```

Create your dialog classes
```ruby
# TODO: Namespace and Class name can be improved

module Hello
  # Initialize Dialog
  class StartDialog
    def process
      # TODO: View-like helper comming soon
      Doll::Message::Text.new('Hi, Human!')
    end
  end
end
```

```ruby
# TODO: Namespace and Class name can be improved

module Buy
  # Initialize Dialog
  class StartDialog
    def process
      # TODO: View-like helper comming soon
      Doll::Message::Text.new('Ok, I know you want buy something')
    end
  end
end
```

Start your server
```bash
$ puma -C config.ru
```

Now, you can access your chatbot via `https://example.com/facebook`

## Development

TODO: Write development guide

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/elct9620/doll.

