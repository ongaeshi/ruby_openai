require "ruby_openai"
require "readline"

token = File.read(".token")
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
  # => "Hello! How may I assist you today?"
end
  
# response = client.chat(
#   parameters: {
#       model: "gpt-3.5-turbo", # Required.
#       messages: [{ role: "user", content: "Hello!"}], # Required.
#       temperature: 0.7,
#   })
# puts response.dig("choices", 0, "message", "content")
# # => "Hello! How may I assist you today?"

# client.chat(
#   parameters: {
#       model: "gpt-3.5-turbo", # 必須
#       messages: [{ role: "user", content: "Explain about color theory, 日本語で"}], # 必須
#       temperature: 1,
#       stream: proc do |chunk, _bytesize|
#           print chunk.dig("choices", 0, "delta", "content")
#       end
#   })

# 色彩理論（しきさいりろん）は、色に関する原則や関係を分析する学問です。色彩は、目の網膜に当たる光の波長によって生じる感覚であり、光の三原色（赤、緑、青）を基に、無彩色や補色などがあります。
# 主な色彩理論の一つは、ウィルヘルム・オストバルトが提唱した「対照説」です。これによれば、色彩は他の色との対比によって知覚されるため、色の対比関係がその色の印象を大きく左右するとされています。対照説に基づき、色相、彩度、明度といった要素が考えられ、これによって色彩配色は調整されます。
# また、彩度（さいど）と明度（めいど）は、色彩理論の重要な要素です。彩度は色の鮮やかさや純度を示し、明度は色の明るさ・暗さを表します。色彩理論においては、一つの色相に対して、彩度や明度を変えることで、より豊かな表現や調和を生み出すことができます。
# また、色彩理論は視覚心理学やデザインにおいても重要な役割を果たします。色彩は情報を伝える力があり、人々の感情や行動にも影響を与えることが知られています。そのため、ビジュアルコミュニケーションや商品デザイン、広告などの分野では、色彩理論を活用することで、目的や効果に応じたカラーパレットや配色を選ぶことが重要とされています。
# 総括すると、色彩理論は色の知覚や調和、効果についての基本的な原則を研究する学問であり、文化や独自の感性によっても異なる要素が存在することがあります。しかし、一般的な色彩理論の知識を持つことで、色彩をより意識的に扱い、創造的な表現や効果的なデザインを追求することができます。
