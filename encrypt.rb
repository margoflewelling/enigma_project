require './lib/enigma'
enigma = Enigma.new

puts "Where is the file located that you want to encrypt?"
file_with_message_to_encrypt = gets.chomp
message = File.read(file_with_message_to_encrypt)
puts "What file do you want to write your encrypted message in?"
file_to_write_to = gets.chomp
encrypted_message = File.open(file_to_write_to, "w")
encrypted_message.write((enigma.encrypt(message))[:encryption])
encrypted_message.close

puts "Created #{file_to_write_to} with the key #{(enigma.encrypt(message))[:key]} and date #{(enigma.encrypt(message))[:date]}"
