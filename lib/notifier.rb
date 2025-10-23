# frozen_string_literal: true

require 'securerandom'

module PromptBox
  class Notifier
    BUNDLED_NOTIFIER = File.expand_path('../../vendor/terminal-notifier.app/Contents/MacOS/terminal-notifier', __dir__)

    def self.binary_path
      return BUNDLED_NOTIFIER if File.exist?(BUNDLED_NOTIFIER)

      'terminal-notifier'
    end

    def initialize(title:)
      @title = title
      @group = "prompt-box-#{SecureRandom.hex(6)}"
      @binary = self.class.binary_path
    end

    def show(message)
      `#{@binary} -title "#{@title}" -message "#{message}" -group "#{@group}" -sender "com.runningwithcrayons.Alfred"`
    end

    def close(after:)
      sleep(after)
      `#{@binary} -remove '#{@group}' > /dev/null`
    end
  end
end
