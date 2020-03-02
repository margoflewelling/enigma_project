require './lib/enigma'
enigma = Enigma.new

puts "Where is the file located that you want to encrypt?"
file_with_message_to_encrypt = gets.chomp
message = File.read(file_with_message_to_encrypt)
puts "What file do you want to write your encrypted message in?"
file_to_write_to = gets.chomp
encrypted_message = File.open(file_to_write_to, "w")
encryption = enigma.encrypt(message)
encrypted_message.write(encryption[:encryption])
require "pry"; binding.pry
encrypted_message.close

puts "Created #{file_to_write_to} with the key #{(encryption[:key])} and date #{encryption[:date]}"
