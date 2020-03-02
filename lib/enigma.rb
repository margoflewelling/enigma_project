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


end
