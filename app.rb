# frozen_string_literal: true

require 'logger'
require 'bundler/setup'

ENV['ENV'] ||= 'development'

module App
  def self.env
    ENV['ENV']
  end
  def self.root
    @root ||= File.dirname(__FILE__)
  end

  def self.file(*paths)
    File.join(root, *paths)
  end

  def self.comparison_path(*paths)
    File.join(root, 'comparison', *paths)
  end
end

Bundler.require(:default, App.env)

def from_env(key, default = nil)
  value = ENV[key]
  return default if value.nil? || value.empty?
  value
end

require_relative '.env_overrides.rb' if File.exist?('.env_overrides.rb')

# $stderr.reopen(File.join('log', "#{env}_warning.log"), 'w')

# Autoload app files
Dir["app/**/*.rb"].each do |file|
  require_relative file
end

Mongoid.load!(App.file('config', 'mongoid.yml'), App.env)

# Mongo::Logger.logger = AppLogger.logger
# Mongoid.logger = AppLogger.logger

Mongo::Logger.logger = Logger.new(App.file('log', "mongo_#{App.env}.log"))
Mongoid.logger = Logger.new(App.file('log', "mongoid_#{App.env}.log"))

Foo.delete_all
Foo.create!(bar: 'Hello World')
AppLogger.info(Foo.first.bar)
