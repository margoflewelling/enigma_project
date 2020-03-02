class Enigma
  attr_accessor :key, :date

  def initialize
  end

  def alphabet
    ("a".."z").to_a << " "
  end

  def create_keys(key)
    keys = {}
    keys["A"] = key[0..1]
    keys["B"] = key[1..2]
    keys["C"] = key[2..3]
    keys["D"] = key[3..4]
    keys
  end

  def create_offsets(date)
    date_squared = (date.to_i * date.to_i).to_s
    last_four = date_squared[-4..-1]
    offsets = {}
    offsets["A"] = last_four[0]
    offsets["B"] = last_four[1]
    offsets["C"] = last_four[2]
    offsets["D"] = last_four[3]
    offsets
  end

  def final_shift(key, date)
    final_shift = {}
    create_keys(key).map do |num_key, key|
      final_shift[num_key] = key.to_i + create_offsets(date)[num_key].to_i
    end
    final_shift
  end

  def split_message(message)
    message.split("")
  end

  def encrypt_message(message, key, date)
    message_letters = split_message(message)
    encrypted = ""
     loop do
       final_shift(key, date).each do |letter, shift|
         index = alphabet.index(message_letters[0])
         if alphabet.include?(message_letters[0])
          encrypted << alphabet.rotate(shift)[index]
         else
            encrypted << message_letters[0]
         end
         message_letters = message_letters.rotate(1)
         break if encrypted.length == message_letters.length
       end
       break if encrypted.length == message_letters.length
     end
   encrypted
  end

  def decrypt_message(message, key, date)
    message_letters = split_message(message)
    decrypted = ""
    loop do
      final_shift(key, date).each do |letter, shift|
        index = alphabet.index(message_letters[0])
        if alphabet.include?(message_letters[0])
         decrypted << alphabet.rotate(-shift)[index]
        else
           decrypted << message_letters[0]
        end
        message_letters = message_letters.rotate(1)
        break if decrypted.length == message_letters.length
      end
      break if decrypted.length == message_letters.length
    end
    decrypted
  end

  def decrypt(message, key, date = today)
    decryption = {}
    decryption[:decryption] = decrypt_message(message, key, date)
    decryption[:key] = key
    decryption[:date] = date
    decryption
  end

  def encrypt(message, key = create_random_key, date = today)
    encryption = {}
    encryption[:encryption] = encrypt_message(message, key, date)
    encryption[:key] = key
    encryption[:date] = date
    encryption
  end

  def create_random_key
    random_key = rand(1..100000).to_s
    until random_key.length == 5 do
      random_key.prepend("0")
    end
    random_key
  end

  def today
    Date.today.strftime("%m%d%y")
  end


end
