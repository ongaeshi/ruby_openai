require "ruby_openai"
require "readline"

token = File.read(File.join(__FILE__, "../.token"))
$client = OpenAI::Client.new(access_token: token)

def gpt(message)
  response = $client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "user", content: message}], # Required.
        temperature: 0.7,
    })
  result = response.dig("choices", 0, "message", "content")
  puts "---\n#{result}"
  result
end

a=gpt("Rubyについて本を書こうと思う。五章構成で英語の目次と各章の概要を書け")
b=gpt("#{a} この目次の第一章を日本語で書け")
c=gpt("#{a} この目次の第二章を日本語で書け")
d=gpt("#{a} この目次の第三章を日本語で書け")
e=gpt("#{a} この目次の第四章を日本語で書け")
f=gpt("#{a} この目次の第五章を日本語で書け")
bs=gpt("#{b}を20文字で要約しろ")
cs=gpt("#{c}を20文字で要約しろ")
ds=gpt("#{d}を20文字で要約しろ")
es=gpt("#{e}を20文字で要約しろ")
fs=gpt("#{f}を20文字で要約しろ")
conclusion=gpt("以下の要約を元に結論を書け 第一章 #{bs} 第二章 #{cs} 第三章 #{ds} 第四章 #{es} 第五章 #{fs}") 
