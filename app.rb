# frozen_string_literal: true

require 'logger'
require 'fileutils'
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

  def self.logger
    return @logger if @logger

    @logger = Logger.new(App.file("log/#{ENV['ENV']}.log"))
    # print to stout and file
    @logger.formatter = proc do |severity, datetime, progname, msg|
      date_format = datetime.strftime("%Y-%m-%d %H:%M:%S")
      to_return = "[#{date_format}] #{severity}: #{msg}\n"
      puts to_return
      to_return
    end
    @logger
  end
end

# Autoload app files
Dir["app/**/*.rb"].each do |file|
  require_relative file
end

Hello.world
