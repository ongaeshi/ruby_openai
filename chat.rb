require "ruby_openai"
require "readline"

IS_STREAM = true

token = File.read(File.join(__FILE__, "../.token"))
client = OpenAI::Client.new(access_token: token)

loop do 
  input = Readline.readline("> ")
  parameters = {
    model: "gpt-3.5-turbo",
    messages: [{ role: "user", content: input}],
    temperature: 0.7
  }
  if IS_STREAM 
    parameters[:stream] = proc do |chunk, _bytesize|
      print chunk.dig("choices", 0, "delta", "content")
    end
  end
  response = client.chat(parameters: parameters)
  if IS_STREAM
    puts
  else
    puts response.dig("choices", 0, "message", "content")
  end
end
