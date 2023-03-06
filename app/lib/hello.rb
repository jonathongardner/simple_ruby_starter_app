# frozen_string_literal: true

module Hello
  def self.world
    App.logger.info("Hello World")
  end
end
