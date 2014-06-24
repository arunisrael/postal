# json parser
require 'json'

# model validations
require 'active_model'

# for http post requests to external apis
require 'uri'
require 'net/http'
require 'net/https'

# html -> plain text converter
require_relative './app/utils/html_to_plain_text'

# load all mailers
Dir['./app/mailers/*.rb'].each { |file| require file }

# message model state + behavior
require_relative './app/models/message'

# app settings
require_relative './app/config/settings'

# prevents deprecation warning from being printed to logs
I18n.enforce_available_locales = false
