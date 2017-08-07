# frozen_string_literal: true

require 'rack'
require 'json'
require 'openssl'
require 'net/http'

require 'doll/version'
require 'doll/config'
require 'doll/server'
require 'doll/request'
require 'doll/response'
require 'doll/converse'
require 'doll/dialog'

require 'doll/adapter/base'
require 'doll/adapter/plain'
require 'doll/adapter/facebook'

require 'doll/event/message'

require 'doll/message/text'

# The Chatbot Framework written in Ruby
module Doll
  def self.config
    @config ||= Config.new
  end

  def self.configure(&block)
    return config unless block_given?
    config.instance_exec(config, &block)
  end

  def self.server
    Server.init
  end

  def self.converse(&block)
    @converse ||= Converse.new
    @converse.instance_eval(&block) if block_given?
  end

  def self.dispatch(event, adapter)
    @converse.dispatch(event, adapter)
  end
end
