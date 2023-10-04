require "ruby_openai"
require "readline"

token = File.read(File.join(__FILE__, "../.token"))
client = OpenAI::Client.new(access_token: token)

loop do 
  input = Readline.readline("> ")
  response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: input}], # Required.
        temperature: 0.7,
    })
  puts response.dig("choices", 0, "message", "content")
end
