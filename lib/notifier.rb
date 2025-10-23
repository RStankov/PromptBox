# frozen_string_literal: true

require 'securerandom'

module PromptBox
  class Notifier
    def initialize(title:)
      @title = title
      @group = "prompt-box-#{SecureRandom.hex(6)}"
    end

    def show(message)
      `terminal-notifier -title "#{@title}" -message "#{message}" -group "#{@group}" -sender "com.runningwithcrayons.Alfred"`
    end

    def close(after:)
      sleep(after)
      `terminal-notifier -remove '#{@group}' > /dev/null`
    end
  end
end
