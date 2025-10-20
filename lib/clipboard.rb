# frozen_string_literal: true

module PromptBox
  module Clipboard
    extend self

    def read
      IO.popen(['pbpaste'], &:read).to_s
    rescue Errno::ENOENT
      raise 'pbpaste command not available'
    end

    def write(text)
      IO.popen(['pbcopy'], 'w') { |io| io.write(text.to_s) }
      status = $?
      raise 'pbcopy command failed' if status && !status.success?
    rescue Errno::ENOENT
      raise 'pbcopy command not available'
    end
  end
end
