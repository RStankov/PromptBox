#!/usr/bin/env ruby

require_relative '../lib/prompts'
require_relative '../lib/alfred'
require_relative '../lib/open_ai_api'

prompt_title = ENV.fetch('prompt_box_prompt_title')
query = ARGV[0].to_s.strip
openai_api_key = ENV.fetch('openai_api_key')

response = "# #{prompt_title}\n"
response << "--- \n"

prompt_instructions = PromptBox::Prompts.find_prompt_instructions(prompt_title)

variables = {
  'prompt_box_output' => '',
}

footer = "↩  Query"

if prompt_instructions.empty?
  response << "**Can't find prompt**"
elsif query.empty?
  response << "Enter query ↩ "
else
  response << "**Input** \n\n"
  response << "```\n#{query}\n``` \n\n"
  response << "**Output** \n\n"

  begin
    output = PromptBox::OpenAIApi.response(
      instructions: prompt_instructions,
      input: query,
      api_key: openai_api_key,
    )

    footer = '↩  Query · ⌘ + ↩  Copy'

    variables['prompt_box_output'] = output

    response << "```\n#{output}\n```"
  rescue => e
    response << "**ERROR**:\n:#{e.message}"
  end
end

PromptBox::Alfred.output(
  PromptBox::Alfred.text_view(
    response,
    variables: variables,
    footer: footer,
  )
)
