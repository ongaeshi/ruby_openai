require "ruby_openai"

client = OpenAI::Client.new(access_token: "access_token_goes_here")

p client
