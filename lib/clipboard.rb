# frozen_string_literal: true

module PromptBox
  module Clipboard
    extend self

    def read
      `osascript -e 'the clipboard as Unicode text'`
    end

    def write(text)
      escaped_text = text.gsub('\\', '\\\\\\\\').gsub('"', '\\\"').gsub("\n", '\\\\n')

      `osascript -e 'set the clipboard to "#{escaped_text}"'`
    end
  end
end
