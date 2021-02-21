# frozen_string_literal: true
require 'fileutils'

module AppLogger
  def self.logger
    return @logger if @logger

    @logger = Logger.new(App.file('log', "#{ENV['ENV']}.log"))
    # print to stout and file
    @logger.formatter = proc do |severity, datetime, progname, msg|
      date_format = datetime.strftime("%Y-%m-%d %H:%M:%S")
      to_return = "[#{date_format}] #{severity}: #{msg}\n"
      puts to_return
      to_return
    end
    @logger
  end

  def self.info(message)
    logger.info(message)
  end

  def self.debug(message)
    logger.debug(message)
  end

  def self.error(message)
    logger.error(message)
  end
end
