# frozen_string_literal: true

require 'openai'
require 'dotenv/load'

class MyDynamicClass
  def method_missing(method_name, *args, &block)
    super
  rescue NoMethodError
    client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])
    puts "You tried to call #{method_name} with arguments: #{args.inspect}"
    response = client.chat(parameters: {
                             model: 'gpt-4',
                             messages: [{ role: 'system',
                                          content: 'You are a master at using Google.' },
                                        { role: 'user',
                                          content: "search the web and find the result of from the context of the Ruby method: #{method_name} with arguments: #{args.inspect}" }],
                             temperature: 0.7
                           })
    puts response.dig('choices', 0, 'message', 'content')
  end

  def respond_to_missing?(method_name, include_private = false)
    method_name.to_s.start_with?('dynamic_') || super
  end
end

# obj = MyDynamicClass.new
# obj.dynamic_hello('world') { puts "Hello from the block!" }
