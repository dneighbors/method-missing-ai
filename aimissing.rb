require 'openai'
require 'dotenv/load'

class MyDynamicClass
  def method_missing(method_name, *args, &block)
      begin
        super
      rescue NoMethodError
        client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])
        puts "You tried to call #{method_name} with arguments: #{args.inspect}"
        response = client.chat(parameters: {
                                  model: 'gpt-3.5-turbo',
                                  messages: [{ role: 'user', content: "act like you executed this method #{method_name} and return only the output you would expect the method to return and nothing else" }],
                                  temperature: 0.7
                                }
        )
        puts response.dig("choices", 0, "message", "content")
      end
  end

  def respond_to_missing?(method_name, include_private = false)
    method_name.to_s.start_with?('dynamic_') || super
  end
end

#obj = MyDynamicClass.new
#obj.dynamic_hello('world') { puts "Hello from the block!" }