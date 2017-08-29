$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
require 'coveralls'

SimpleCov.start do
  formatter SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      Coveralls::SimpleCov::Formatter
    ]
  )

  load_profile 'test_frameworks'

  add_group 'Adapter', 'lib/doll/adapter'
  add_group 'NLP', 'lib/doll/nlp'
  add_group 'Event', 'lib/doll/event'
  add_group 'Message', 'lib/doll/message'
end

require 'doll'
