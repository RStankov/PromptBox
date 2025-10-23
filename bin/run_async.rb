#!/usr/bin/env ruby

require_relative '../lib/prompts'
require_relative '../lib/notifier'
require_relative '../lib/open_ai_api'

prompt_title = ENV.fetch('prompt_box_prompt_title')
query = ARGV[0].to_s.strip
openai_api_key = ENV.fetch('openai_api_key')
openai_model = ENV.fetch('openai_model', 'gpt-5-mini')

prompt_instructions = PromptBox::Prompts.find_prompt_instructions(prompt_title)

exit 1 if prompt_instructions.empty?
exit 1 if query.empty?

notifier = PromptBox::Notifier.new(title: 'PromptBox')
notifier.show("🚧 Running #{prompt_title}...")

begin
  output = PromptBox::OpenAIApi.response(
    model: openai_model,
    instructions: prompt_instructions,
    input: query,
    api_key: openai_api_key
  )

  IO.popen(['pbcopy'], 'w') { |pipe| pipe.write(output) }

  notifier.show('✅ Result copied to clipboard')
rescue StandardError => e
  notifier.show("🔴 Error: #{e.message}")
  exit 1
end
