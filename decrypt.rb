require './lib/enigma'
enigma = Enigma.new

file_with_message_to_decrypt = ARGV[0]
message = File.read(file_with_message_to_decrypt)
file_to_write_to = ARGV[1]
decrypted_message = File.open(file_to_write_to, "w")
key = ARGV[2]
date = ARGV[3]

decryption = enigma.decrypt(message, key, date)
decrypted_message.write(decryption[:decryption])
decrypted_message.close

puts "Created #{file_to_write_to} with the key #{key} and date #{date}"
