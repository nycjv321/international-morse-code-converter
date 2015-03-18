# This class provides the ability to translate standard ASCII to International Morse Code
#   It also provides functions to translate to_morse code (dots (.) and dashes(-) to text)
module Morse
  class Converter
    DOT = ?..to_sym
    DASH = ?-.to_sym

    NUMERALS = {
        1 => "#{DOT}#{DASH}#{DASH}#{DASH}#{DASH}", 2 => "#{DOT}#{DOT}#{DASH}#{DASH}#{DASH}",
        3 => "#{DOT}#{DOT}#{DOT}#{DASH}#{DASH}", 4 => "#{DOT}#{DOT}#{DOT}#{DOT}#{DASH}",
        5 => "#{DOT}#{DOT}#{DOT}#{DOT}#{DOT}", 6 => "#{DASH}#{DOT}#{DOT}#{DOT}#{DOT}",
        7 => "#{DASH}#{DASH}#{DOT}#{DOT}#{DOT}", 8 => "#{DASH}#{DASH}#{DASH}#{DOT}#{DOT}",
        9 => "#{DASH}#{DASH}#{DASH}#{DASH}#{DOT}", 0 => "#{DASH}#{DASH}#{DASH}#{DASH}#{DASH}"
    }

    LETTERS = {
        A: "#{DOT}#{DASH}", B: "#{DASH}#{DOT}#{DOT}#{DOT}", C: "#{DASH}#{DOT}#{DASH}#{DOT}",
        D: "#{DASH}#{DOT}#{DOT}", E: "#{DOT}", F: "#{DOT}#{DOT}#{DASH}#{DOT}", G: "#{DASH}#{DASH}#{DOT}",
        H: "#{DOT}#{DOT}#{DOT}#{DOT}", I: "#{DOT}#{DOT}", J: "#{DOT}#{DASH}#{DASH}#{DASH}",
        K: "#{DASH}#{DOT}#{DASH}", L: "#{DOT}#{DASH}#{DOT}#{DOT}", M: "#{DASH}#{DASH}", N: "#{DASH}#{DOT}",
        O: "#{DASH}#{DASH}#{DASH}", P: "#{DOT}#{DASH}#{DASH}#{DOT}", Q: "#{DASH}#{DASH}#{DOT}#{DASH}",
        R: "#{DOT}#{DASH}#{DOT}", S: "#{DOT}#{DOT}#{DOT}", T: "#{DASH}", U: "#{DOT}#{DOT}#{DASH}",
        V: "#{DOT}#{DOT}#{DOT}#{DASH}", W: "#{DOT}#{DASH}#{DASH}", X: "#{DASH}#{DOT}#{DOT}#{DASH}",
        Y: "#{DASH}#{DOT}#{DASH}#{DASH}", Z: "#{DASH}#{DASH}#{DOT}#{DOT}"
    }

    ALPHABET = NUMERALS.merge(LETTERS)
    SHORT_GAP = ' ' * 3
    LONG_GAP = ' ' * 7

    # Returns standard SOS to_string
    # @return [String] "...   ---   ..."
    def self.sos
      to_morse "SOS"
    end

    # Converts a morse encoded string to plain text
    # @param morse_code [String] the to_morse code to_string
    # @return [String] a String that represents the to_morse code
    def self.to_string(morse_code)
      value = ''
      words = morse_code.split(LONG_GAP)
      words.each do |word|
        value << morse_word_to_string(word.split(SHORT_GAP)) << ' '
      end
      value.strip
    end

    # Converts a morse encoded word to its alphanumeric equivalent
    # @param word [String] morse code encoded word
    # @return [String] a String that represents alphanumeric form of the morse encoded word
    def self.morse_word_to_string(word)
      value = ''
      word.each do |letter|
        alphabet_key = ALPHABET.key(letter)
        next if alphabet_key.nil?
        value << alphabet_key.to_s
      end
      value
    end

    :private

    # Converts a alphanumeric word to International Morse Code
    # @param word [String] a String to convert to morse code
    # @return [String] the morse code equivalent of the provided word
    def self.alphabetic_word_to_morse(word)
      morse = ''
      word.split('').each do |letter|
        if letter.is_numeric?
          morse = morse + ALPHABET[letter.to_i]
        else
          value = ALPHABET[letter.upcase.to_sym]
          next if value.nil?
          morse = morse + value
        end
        morse << SHORT_GAP
      end
      morse
    end

    :private

    # Converts a string to International Morse Code
    # @param string [String] a String to convert to morse code
    # @return [String] the morse code representation of the provided string
    def self.to_morse(string)
      morse = ''
      words = string.to_s.split ' '
      words.each do |word|
        morse << alphabetic_word_to_morse(word).strip! << LONG_GAP
      end
      morse.strip
    end
  end


end

class String
  def is_numeric?
    !self.match(/\A[+-]?\d+?(\.\d+)?\Z/).nil?
  end
end
