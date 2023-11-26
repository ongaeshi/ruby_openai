require "ruby_openai"
require "readline"
require "open-uri"
require "net/http"

token = File.read(File.join(__FILE__, "../.token"))
output_dir = File.join(File.dirname(__FILE__), "output")
client = OpenAI::Client.new(access_token: token)

def download_image(url, destination_path)
  URI.open(url) do |res|
    IO.copy_stream(res, destination_path)
  end
end

response = client.images.generate(parameters: {
  model: "dall-e-2", # "dall-e-3"
  # prompt: 'Use pixel art to represent the single weapon in a "Halloween" themed game as "fireball". Create the background with black for transparency. Square. Use larger pixel dots.', 
  # prompt: 'Use pixel art to represent the single enemy in a "Halloween" themed game as "cute ghost". Create the background with black for transparency. Square. Use larger pixel dots.', 
  # prompt: 'Use pixel art to represent the single hero in a "Halloween" themed game as "cute small knight". Create the background with black. Square. Use larger pixel dots.', 
  # prompt: 'Use pixel art to represent the single hero in a "Cyberpunk" themed game as "cute small knight". Create the background with black. Square. Use larger pixel dots.', 
  # prompt: 'Use pixel art to represent the single hero in a "Cyberpunk" themed game as "young boy". Create the background with black. Square. From side to right. Use larger pixel dots.', 
  # prompt: 'Use pixel art to represent the single hero in a "Cyberpunk" themed game as "boy with gun". Create the background with black. Square. From side to right. Use larger pixel dots.', 
  prompt: 'Use pixel art to represent the single hero in a "Age of Exploration" themed game as "pirate girl". Create the background with black. Square. From side to right. Use larger pixel dots.', 
  size: "256x256", # "1024x1024", 
  n: 1
  })
# p response
url = response.dig("data", 0, "url")
# puts url

timestamp = Time.now.strftime("%Y%m%d%H%M%S")
name = "player1_#{timestamp}.png"
path = File.join(output_dir, name)
puts "Save to #{path}"
download_image(url, path)