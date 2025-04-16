require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_KEY"))

message_list = [
  {
    "role" => "system",
    "content" => "You are a helpful assistant."
  }
]

puts "Hello! How can I help you today?"
puts "-" * 50
user_input = ""

while user_input != "bye"

  user_input = gets.chomp
  if user_input != "bye"
    message_list.push({"role" => "user","content" => user_input})

    api_response = client.chat(
      parameters: {
      model: "gpt-3.5-turbo",
      messages: message_list
    }
  )
    feedback = api_response.fetch("choices").at(0).fetch("message")
    answer = feedback.fetch("content")

    puts answer
    puts "-" * 50

    message_list.push({ "role" => "assistant", "content" => answer })
  end
end

puts "Goodbye! If you have any more questions in the future, feel free to ask. Have a great day!"
