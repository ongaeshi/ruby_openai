require "ruby_openai"
require "readline"
require "open-uri"
require "net/http"

token = File.read(File.join(__FILE__, "../.token"))
$output_dir = File.join(File.dirname(__FILE__), "output")
$client = OpenAI::Client.new(access_token: token)

def download_image(url, destination_path)
  URI.open(url) do |res|
    IO.copy_stream(res, destination_path)
  end
end

def generate_image(model, prompt, size)
  # https://platform.openai.com/docs/api-reference/images/create
  response = $client.images.generate(parameters: {
    # "dall-e-2" OR "dall-e-3"
    model: model,
    # dall-e-2: 1000 characters
    # dall-e-3: 4000 characters
    prompt: prompt,
    # dall-e-2: 256x256, 512x512, or 1024x1024
    # dall-e-3: 1024x1024, 1024x1792 or 1792x1024
    size: size,
    })
end

def generate_common_game_asset(thema, data)
  timestamp = Time.now.strftime("%Y%m%d%H%M%S")
  data.each do |d|
    response = if d[:kind] =~ /background/
      generate_image(
        "dall-e-3",
        "Use pixel art to represent the #{d[:kind]} in a '#{thema}' themed game as '#{d[:description]}'. 16x9. Use larger pixel dots. Color scheme that does not interfere with game play.",
        "1792x1024"
      )
    elsif d[:kind] =~ /tile/
      generate_image(
        "dall-e-3",
        "Use pixel art to represent squared tilemap materials that can be used in game engines in a '#{thema}' themed game as '#{d[:description]}'.",
        "1024x1024"
      )
    else
      generate_image(
        "dall-e-2",
        "Use pixel art to represent the single #{d[:kind]} in a '#{thema}' themed game as '#{d[:description]}'. Create the background with black. Square. From side to right. Use larger pixel dots.",
        "256x256"
      )
    end
    url = response.dig("data", 0, "url")
    name = "#{d[:kind]}_#{timestamp}.png"
    path = File.join($output_dir, name)
    download_image(url, path)
    puts "Save to #{path}"
  end
end

generate_common_game_asset(
  "Age of Exploration",
  [
    {kind: "player1", description: "Cute Pirate Girl"},
    {kind: "enemy1", description: "Sneaky skeletons"},
    {kind: "weapon1", description: "Lightning flying sideways"},
    {kind: "item1", description: "A delightful treasure"},
    {kind: "tile1", description: "Wood"},
    {kind: "background1", description: "Bar"}    
  ]
)
