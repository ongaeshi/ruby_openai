require "ruby_openai"
require "readline"

token = File.read(File.join(__FILE__, "../.token"))
$client = OpenAI::Client.new(access_token: token)

response = $client.images.generate(parameters: { prompt: "A baby sea otter cooking pasta wearing a hat of some sort", size: "256x256" })
puts response.dig("data", 0, "url")
# => "https://oaidalleapiprodscus.blob.core.windows.net/private/org-Rf437IxKhh..."
