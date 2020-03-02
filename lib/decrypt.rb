require './lib/enigma'
enigma = Enigma.new

message = File.read(ARGV[0])
decrypted_message = File.open(ARGV[1], "w")
key = ARGV[2]
date = ARGV[3]

decryption = enigma.decrypt(message, key, date)
decrypted_message.write(decryption[:decryption])
decrypted_message.close

puts "Created #{ARGV[1]} with the key #{key} and date #{date}"
