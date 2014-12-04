require "Win32API"
require_relative 'morse_utility'

# This class provides the ability to translate standard ASCII to International Morse Code
#   It also provides functions to translate to_morse code (dots (.) and dashes(-) to text)
#   And lastly, it provides the ability to beep (on Win32 Platforms). Because of this,
#   this code should not work on Linux. Assistance on porting this code is welcome.
module Morse
  class Converter_win32 < Converter
    BEEP = Win32API.new("kernel32", "Beep", ["I", "I"], 'v')

    def self.beep freq, duration
      BEEP.call(freq, duration)
    end

    :private

    # Communicates to_morse code
    #   Dots (.) and Dashes (-) are communicated at 100 & 300 ms respectively, both at 500hz.
    #   A 300 ms pause occurs after each letter, and a 700ms pause occurs after each word
    # @param morse_code [String] the to_morse code to_string
    def self.communicate(string)
      words = string.split(LONG_GAP)
      words.each do |word|
        word = word.split(SHORT_GAP)
        word.each do |letter|
          letter.split('').each do |code|
            if code == Morse::Converter::DOT.to_s
              self.beep 500, 100
            elsif code == Morse::Converter::DASH.to_s
              self.beep 500, 300
            end
          end
          sleep 0.3
        end
        sleep 0.7
      end

    end
  end

end