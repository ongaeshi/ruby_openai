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
    puts "Save to #{path}"
    download_image(url, path)
  end
end

generate_common_game_asset(
  "Halloween",
  [
    # {kind: "player1", description: "Cute Ghost"},
    # {kind: "enemy1", description: "Scary Pumpkin"},
    # {kind: "weapon1", description: "Fireball"},
    # {kind: "item1", description: "Lucky Coin"},
    # {kind: "tile1", description: "Brick tile"},
    {kind: "background1", description: "Halloween Party"}    
  ]
)
