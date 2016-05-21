require 'logger'
require 'smspilot/version'

module Smspilot
  module Configuration
    VALID_OPTIONS_KEYS = [:endpoint, :user_agent, :adapter, :timeout, :api_key, :logger, :login, :password]

    DEFAULT_ADAPTER     = :net_http
    DEFAULT_ENDPOINT    = 'http://smspilot.ru/api2.php'
    DEFAULT_USER_AGENT  = "smspilot gem #{Smspilot::VERSION}".freeze
    DEFAULT_TIMEOUT     = 5
    DEFAILT_API_KEY     = nil
    DEFAILT_LOGIN       = nil
    DEFAILT_PASSWORD    = nil
    DEFAILT_LOGGER      = Logger.new("log/smspilot.log")

    attr_accessor *VALID_OPTIONS_KEYS

    def configure
      yield self
    end

    def self.extended(base)
      base.reset
    end

    def options
      options = {}
      VALID_OPTIONS_KEYS.each{|k| options[k] = send(k)}
      options
    end

    def reset
      self.adapter    = DEFAULT_ADAPTER
      self.endpoint   = DEFAULT_ENDPOINT
      self.user_agent = DEFAULT_USER_AGENT
      self.timeout    = DEFAULT_TIMEOUT
      self.api_key    = DEFAILT_API_KEY
      self.login      = DEFAILT_LOGIN
      self.password   = DEFAILT_PASSWORD
      self.logger     = DEFAILT_LOGGER
      self
    end
  end
end