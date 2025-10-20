# frozen_string_literal: true

require 'net/http'
require 'json'

module PromptBox
  module OpenAIApi
    extend self

    # NOTE(rstankov): https://platform.openai.com/docs/api-reference/responses
    def response(model:, instructions:, input:, api_key:)
      uri = URI('https://api.openai.com/v1/responses')

      request = Net::HTTP::Post.new(
        uri,
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{api_key}",
      )

      request.body = JSON.dump({
        model: model,
        instructions: instructions,
        input: input,
      }.compact)

      # 120 - 2 minutes
      http_response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true, open_timeout: 20, read_timeout: 1200) do |http|
        http.request(request)
      end

      response = JSON.parse(http_response.body)

      raise response['error']['message'] unless response['error'].nil?

      message = response['output'].reverse.find { |o| o['type'] == 'message' && o['status'] == 'completed' }
      raise 'No output message returned' if message.nil?

      text_block = message['content']&.find { |c| c['type'] == 'output_text' && !c['text'].empty? }
      raise "No output text returned" if text_block.nil?

      text_block['text']
    end
  end
end
