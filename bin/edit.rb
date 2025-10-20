# frozen_string_literal: true

require_relative '../lib/prompts'

path = PromptBox::Prompts.promt_file_path
File.write(path, '') unless File.exist?(path)

`open #{path.to_s}`
