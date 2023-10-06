# @note To read
class ShortCode
  ALPHABET = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".freeze
  BASE = ALPHABET.length

  # Encodes a number into a short string.
  #
  # @param number [Integer] The number to encode.
  # @return [String] The encoded string.
  def self.encode(number)
    return ALPHABET.first if number.zero? || number.nil?

    result = ""

    while number > 0 do
      index = number % BASE
      char = ALPHABET[index]
      result.prepend char
      number = number / BASE
    end

    result
  end

  # Decodes a short string into a number.
  #
  # @param string [String] The short string to decode.
  # @return [Integer] The decoded number.
  def self.decode(string)
    number = 0

    string.reverse.each_char.with_index do |char, index|
      power = BASE**index # 62^0, 62^1, 62^2, ...
      index = ALPHABET.index(char)
      number += index * power
    end

    number
  end
end
