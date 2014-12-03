require 'spec_helper'
module Morse
  describe Converter do
    describe '::DOT' do
      it 'represents a single dot (a single unit)' do
        expect(Converter::DOT).to eql(?..to_sym)
      end
    end

    describe '::DASH' do
      it 'represents 3 units' do
        expect(Converter::DASH).to eql(?-.to_sym)
      end
    end

    describe '::SHORT_GAP' do
      it 'represents a space between letters within the same word' do
        expect(Converter::SHORT_GAP).to eql(" " * 3)
      end
    end

    describe '::LONG_GAP' do
      it 'represents a space between two words' do
        expect(Converter::LONG_GAP).to eql(" " * 7)
      end
    end

    describe '#SOS' do
      it 'equals "...   ---   ..."' do
        expect(Converter.SOS).to eql('...   ---   ...')
      end
    end

    describe '#to_string' do
      it 'converts empty' do
        expect(Converter.to_string('')).to be_empty
      end
      it 'converts numeric' do
        expect(Converter.to_string('-----   .----   ..---   ...--   ....-   .....   -....   --...   ---..   ----.')).to eql("0123456789")
      end
      it 'converts alpha' do
        expect(Converter.to_string('.-   -...   -.-.   -..   .   ..-.   --.   ....   ..   .---   -.-   .-..   --   -.   ---   .--.   --.-   .-.   ...   -   ..-   ...-   .--   -..-   -.--   --..')).to eql('abcdefghijklmnopqrstuvwxyz'.upcase)
      end
      it 'converts morse code to text' do
        expect(Converter.to_string('.---   .-   ...-   ..   .   .-.       .-..       ...-   .   .-..   .-   ...   --.-   ..-   .   --..')).to eql('Javier L Velasquez'.upcase)
      end
    end

    describe '#to_morse' do
      it 'converts empty' do
        expect(Converter.to_morse('')).to be_empty
      end
      it 'separates character by 3 spaces (' ')' do
        expect(Converter.to_morse('10')).to include(' ' * 3)
      end
      it 'separates words by 7 spaces (' ')' do
        expect(Converter.to_morse('Hello World')).to include(' ' *7)
      end
      it 'converts numeric' do
        expect(Converter.to_morse('0123456789')).to eql('-----   .----   ..---   ...--   ....-   .....   -....   --...   ---..   ----.')
      end
      it 'converts alpha' do
        expect(Converter.to_morse('abcdefghijklmnopqrstuvwxyz')).to eql('.-   -...   -.-.   -..   .   ..-.   --.   ....   ..   .---   -.-   .-..   --   -.   ---   .--.   --.-   .-.   ...   -   ..-   ...-   .--   -..-   -.--   --..')
      end
      it 'converts text to morse code' do
        expect(Converter.to_morse('Javier L. Velasquez')).to eql('.---   .-   ...-   ..   .   .-.       .-..       ...-   .   .-..   .-   ...   --.-   ..-   .   --..')
      end
    end
  end
end