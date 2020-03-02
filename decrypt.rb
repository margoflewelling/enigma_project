require './lib/enigma'
enigma = Enigma.new

puts "Where is the file located that you want to decrypt?"
file_with_message_to_decrypt = gets.chomp
message = File.read(file_with_message_to_decrypt)
puts "Where do you want to write your decrypted message in?"
file_to_write_to = gets.chomp
decrypted_message = File.open(file_to_write_to, "w")
puts "What is the key for decryption?"
key = gets.chomp.to_s
puts "What is the date for decryption?"
date = gets.chomp.to_s

decryption = enigma.decrypt(message, key, date)
decrypted_message.write(decryption[:decryption])
decrypted_message.close

puts "Created #{file_to_write_to} with the key #{key} and date #{date}"
