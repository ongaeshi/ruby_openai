require "ruby_openai"
require "readline"

token = File.read(File.join(__FILE__, "../.token"))
$client = OpenAI::Client.new(access_token: token)

def gpt(message, title)
  response = $client.chat(
    parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: message}],
        temperature: 0.7,
    })
  result = response.dig("choices", 0, "message", "content")
  puts "--- #{title} ---\n#{result}"
  result
end

response = $client.chat(
  parameters: {
      model: "gpt-3.5-turbo",
      messages: [{ role: "system", content: "あなたは私の文章をよりよいものにしてくれる優秀な編集者です。"}],
      temperature: 0.7,
  })
# puts response.dig("choices", 0, "message", "content")

desription = ARGV[0]
gpt("「#{desription}」を紹介するバズるツイート文を教えて", "バズ優先")
gpt("「#{desription}」を紹介する落ち着いたツイート文を教えて", "落ち着き優先")
gpt("「#{desription}」を紹介する技術者が書きそうなツイート文を教えて", "技術者")
gpt("「#{desription}」を紹介するテクニカルライターが書きそうなツイート文を教えて", "テクニカルライター")
gpt("「#{desription}」を紹介するインフルエンサーが書きそうなツイート文を教えて", "インフルエンサー")