require './lib/enigma'
enigma = Enigma.new

message = File.read(ARGV[0])
encrypted_message = File.open(ARGV[1], "w")
encryption = enigma.encrypt(message)
encrypted_message.write(encryption[:encryption])
encrypted_message.close

puts "Created #{ARGV[1]} with the key #{(encryption[:key])} and date #{encryption[:date]}"
