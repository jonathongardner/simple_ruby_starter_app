# frozen_string_literal: true

require 'logger'
require 'bundler/setup'

env = ENV['ENV'] ||= 'development'
Bundler.require(:default, env.to_sym)

def from_env(key, default = nil)
  value = ENV[key]
  return default if value.nil? || value.empty?
  value
end

require_relative '.env_overrides.rb' if File.exist?('.env_overrides.rb')

# $stderr.reopen(File.join('log', "#{env}_warning.log"), 'w')

module App
  def self.root
    @root ||= File.dirname(__FILE__)
  end

  def self.file(*paths)
    File.join(root, *paths)
  end
end

# Autoload app files
Dir["app/**/*.rb"].each do |file|
  require_relative file
end

AppLogger.info("Hello World!")
