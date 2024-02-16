require 'openai'
require 'dotenv/load'

class MyDynamicClass
  def method_missing(method_name, *args, &block)
    begin
      super
    rescue NoMethodError
      client = OpenAI::Client.new(access_token: ENV['OPENAI_ACCESS_TOKEN'])
      #debug      puts "You tried to call #{method_name} with arguments: #{args.inspect}"
      response = client.chat(
        parameters: {
          model: 'gpt-4',
          messages: [
            { role: 'system', content: 'You are a junior Ruby developer.' },
            { role: 'user', content: "Create a method name: #{method_name} with the arguments: #{args.inspect}." },
            { role: 'user', content: "Based on that method predict a result of calling the method with: #{args.inspect}" }
          ],
          functions: [missing_method_function],
          temperature: 0.7
        }
      )
      handle_functions_response(response)
    end
  end

  def handle_functions_response(response)
    message = response.dig('choices', 0, 'message')
    return unless message['role'] == 'assistant' && message['function_call']

    function_name = message.dig('function_call', 'name')
    args =
      JSON.parse(
        message.dig('function_call', 'arguments'),
        { symbolize_names: true }
      )
    send(function_name, **args)
  end

  def function_eval(result:)
    result
  end

  def missing_method_function
    { name: 'function_eval',
      description: 'This method returns the result of the method call.',
      parameters: {
        type: 'object',
        properties: missing_method_properties,
        required: ['result']
      }
    }
  end

  def missing_method_properties
    {
      result: { type: 'string', description: 'The result of the method call.' }
    }
  end

end