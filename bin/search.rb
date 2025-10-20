#!/usr/bin/env ruby

require_relative '../lib/prompts'
require_relative '../lib/alfred'

query = ARGV[0]

titles = PromptBox::Prompts.list_prompt_titles(query)

PromptBox::Alfred.output(
  PromptBox::Alfred.items(titles)
)
