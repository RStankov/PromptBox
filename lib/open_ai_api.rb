# frozen_string_literal: true

require 'net/http'
require 'json'

module PromptBox
  module OpenAIApi
    extend self

    def response(instructions:, input:, api_key:)
      uri = URI('https://api.openai.com/v1/chat/completions')

      request = Net::HTTP::Post.new(
        uri,
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{api_key}",
      )

      request.body = JSON.dump(
        model: 'gpt-4o-mini', # 'gpt-4o',
        messages: [{
          role: 'system',
          content: instructions,
        },
        {
          role: 'user',
          content: input,
        }],
        temperature: 1,
        max_tokens: 2000,
        top_p: 1,
        frequency_penalty: 0,
        presence_penalty: 0,
      )

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      json_response = JSON.parse(response.body)
      json_response['choices'][0]['message']['content']
    rescue StandardError => e
      "ERROR: #{e.message}"
    end
  end
end
