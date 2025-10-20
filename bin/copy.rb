#!/usr/bin/env ruby

require_relative '../lib/alfred'
require_relative '../lib/clipboard'

output = ARGV[0].to_s.strip

PromptBox::Clipboard.write(output) unless output.empty?
