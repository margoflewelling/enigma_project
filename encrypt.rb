require './lib/enigma'
enigma = Enigma.new

file_with_message_to_encrypt = ARGV[0]
message = File.read(file_with_message_to_encrypt)
file_to_write_to = ARGV[1]
encrypted_message = File.open(file_to_write_to, "w")
encryption = enigma.encrypt(message)
encrypted_message.write(encryption[:encryption])
encrypted_message.close

puts "Created #{file_to_write_to} with the key #{(encryption[:key])} and date #{encryption[:date]}"
