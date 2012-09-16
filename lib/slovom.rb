#encoding: utf-8
require "slovom/version"
require 'bigdecimal'

class BigDecimal
  def slovom
    Slovom::Verbalizer.new(self).to_s
  end
end

module Slovom
  class Verbalizer

    attributes = %w{decimal levs stotinki output levs_title stotinki_title too_big}
    attributes.each {|attribute| attr_accessor attribute.to_sym }

    def initialize(decimal)
      @decimal = decimal.round(2)
      @levs = @decimal.fix.to_i
      @stotinki = ((@decimal.frac.to_s('F').gsub("0.", ''))+"0")[0..1].to_i
      @levs == 1 ? @levs_title = " лев" : @levs_title = " лева"
      @stotinki == 1 ? @stotinki_title = " стотинка" : @stotinki_title = " стотинки"
      @too_big = "много"
      @output = ""
      @output += numbers_slovom(@levs) + @levs_title unless numbers_slovom(@levs).nil? || numbers_slovom(@levs) == "много"
      @output += " и " unless numbers_slovom(@levs).nil? || numbers_slovom(@levs) == "много" || numbers_slovom(@stotinki, feminine=true).nil? || numbers_slovom(@stotinki, feminine=true) == "много"
      @output += numbers_slovom(@stotinki, feminine=true) + @stotinki_title unless numbers_slovom(@stotinki, feminine=true).nil? || numbers_slovom(@stotinki, feminine=true) == "много"
    end

    def to_s
      @output
    end

  private

    def numbers_slovom(ammount, feminine=nil)
      case ammount
        when 1..99 then below_hundred(ammount, feminine)
        when 100..999 then hundreds(ammount, feminine)
        when 1000..999999 then thousands(ammount, feminine)
        when 1000000..999999999999999 then gazillions(ammount, feminine)
        else
          @too_big
      end
    end

    def below_hundred(digits, feminine=nil)
      case digits
      when 1..19 then basic_number(digits, feminine)
      when 20..99 then round_ten(digits, feminine)
      end
    end

    def basic_number(digits, feminine=nil)
      case digits
        when 1 then
          feminine == true ? "една" : "един"
        when 2 then
          feminine == true ? "две" : "два"
        when 3 then "три"
        when 4 then "четири"
        when 5 then "пет"
        when 6 then "шест"
        when 7 then "седем"
        when 8 then "осем"
        when 9 then "девет"
        when 10 then "десет"
        when 11 then "единадесет"
        when 12 then "дванадесет"
        when 13..19 then basic_number(digits.to_s[1].to_i)+"надесет"
      end
    end

    def round_ten(digits, feminine=nil)
      second_digit = digits.to_s.reverse.chr.to_i
      output = basic_number(digits.to_s[0].to_i)+"десет"
      output += " и " + basic_number(second_digit, feminine) unless second_digit == 0
      return output
    end

    def hundreds(digits, feminine=nil)
      final_digits = digits.to_s[1..3].to_i
      first_digit = digits.to_s[0].to_i
      case first_digit
        when 1 then hh = "сто"
        when 2 then hh = "двеста"
        when 3 then hh = "триста"
        when 4..9 then hh = basic_number(first_digit)+"стотин"
      end
      output = hh
      case final_digits
        when 1..20 then output += " и "
      end
      output += " " + numbers_slovom(final_digits, feminine) unless final_digits == 0
      return output.gsub(/\s+/, " ").strip
    end

    def thousands(digits, feminine=nil)
      count = digits.to_s.length
      case count
        when 4 then
          small = digits.to_s[0].to_i
          small == 1 ? hh = "хиляда " : hh = numbers_slovom(small, feminine = true) + " хиляди "
          big = digits.to_s[1..3].to_i
        when 5 then
          small = digits.to_s[0..1].to_i
          hh = numbers_slovom(small, feminine = true) + " хиляди "
          big = digits.to_s[2..4].to_i
        when 6 then
          small = digits.to_s[0..2].to_i
          hh = numbers_slovom(small, feminine = true) + " хиляди "
          big = digits.to_s[3..5].to_i
      end
      output = hh
      output += " и " unless (numbers_slovom(big).include?(" и ") && big.to_s.length == 3) or numbers_slovom(big) == "много"
      output += numbers_slovom(big) unless big == 0
      return output.gsub(/\s+/, " ").strip
    end

    def gazillions(digits, feminine=nil)
      count = digits.to_s.length
      case count
        when 7..9 then
          base_count = 7
          word_plural = " милиона "; word_singular = " милион "
        when 10..12 then
          base_count = 10
          word_plural = " милиарда "; word_singular = " милиард "
        when 13..15 then
          base_count = 13
          word_plural = " трилиона "; word_singular = " трилион "
      end
      if count == base_count
        big_number = digits.to_s[0].to_i
        small_number = digits.to_s[1..24].to_i
      elsif count == base_count + 1
        big_number = digits.to_s[0..1].to_i
        small_number = digits.to_s[2..24].to_i
      elsif count == base_count + 2
        big_number = digits.to_s[0..2].to_i
        small_number = digits.to_s[3..24].to_i
      end
      big_number == 1 ? word = word_singular : word = word_plural

      output = numbers_slovom(big_number) + word
      output += " и " unless numbers_slovom(small_number).include? " и " or numbers_slovom(small_number) == "много"
      output += numbers_slovom(small_number) unless numbers_slovom(small_number) == "много"
      return output.gsub(/\s+/, " ").strip
    end

  end
end
