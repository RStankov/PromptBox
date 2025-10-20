# frozen_string_literal: true

module PromptBox
  module Prompts
    extend self

    def list_prompt_titles(query = '')
      query = query.to_s.downcase.gsub(/\s+/, '')

      titles = prompt_file_content.scan(/^## (.+)$/).flatten.sort

      return titles if query.empty?

      titles.select { |title| fuzzy_match?(title, query) }
    end

    def find_prompt_instructions(title)
      sections = prompt_file_content.split(/^## /)
      sections.shift if sections.first.strip.empty?

      sections.each do |section|
        lines = section.lines
        section_title = lines.first.strip
        section_content = lines[1..].join.strip

        return section_content if section_title == title
      end

      nil
    end

    def promt_file_path
      File.join(__dir__, '..', 'prompts.txt')
    end

    private

    def fuzzy_match?(title, query)
      title_normalized = title.downcase.gsub(/[^a-z0-9]/, '')
      query_chars = query.chars
      title_pos = 0

      query_chars.all? do |query_char|
        title_pos = title_normalized.index(query_char, title_pos)
        return false unless title_pos

        title_pos += 1
        true
      end
    end

    def prompt_file_content
      path = promt_file_path
      File.write(path, '') unless File.exist?(path)
      File.read(path)
    rescue Errno::ENOENT
      File.write(path, '')
      ''
    end
  end
end
