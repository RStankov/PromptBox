# frozen_string_literal: true

require 'json'

module PromptBox
  module Alfred
    extend self

    # NOTE(rstankov): https://www.alfredapp.com/help/workflows/inputs/script-filter/json/
    def items(items)
      items = items.map do |item|
        {
          title: item,
          arg: item,
          icon: {
            path: "./icon.png",
          }
        }
      end

      { items: items }
    end

    # NOTE(rstankov): https://www.alfredapp.com/help/workflows/user-interface/text/json/
    def text_view(response, variables: {}, footer: '')
      {
        variables: variables,
        response: response,
        footer: footer.to_s,
        behaviour: {
          response: 'replace',
          scroll: 'end',
          inputfield: 'clear',
        }
      }
    end

    def output(object)
      puts JSON.generate(object)
    end
  end
end
