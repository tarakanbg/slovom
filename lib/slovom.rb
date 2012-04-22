#encoding: utf-8
require "slovom/version"
require 'bigdecimal'

class BigDecimal
  def slovom
    Slovom.slovom(self)
  end
end

module Slovom
  def self.slovom(input)
    input = input.round(2)
    levs = input.fix.to_i
    stotinki = input.frac.to_s('F').gsub("0.", '')
    stotinki = (stotinki+"0")[0..1].to_i
    output = ""
    output += levs_slovom(levs) + levs_title(levs) unless levs_slovom(levs).nil? || levs_slovom(levs) == "много"
    output += " и " unless levs_slovom(levs).nil? || levs_slovom(levs) == "много" || levs_slovom(stotinki, feminine=true).nil? || levs_slovom(stotinki, feminine=true) == "много"
    output += levs_slovom(stotinki, feminine=true) + stotinki_title(stotinki) unless levs_slovom(stotinki, feminine=true).nil? || levs_slovom(stotinki, feminine=true) == "много"
    return output
  end

private
  def self.too_big
    "много"
  end

  def self.levs_title(levs)
    levs == 1 ? " лев" : " лева"
  end

  def self.stotinki_title(stotinki)
    stotinki == 1 ? " стотинка" : " стотинки"
  end

  def self.levs_slovom(levs, feminine=nil)
    case levs
      when 1..99 then below_hundred(levs, feminine)
      when 100..999 then hundreds(levs, feminine)
      when 1000..999999 then thousands(levs, feminine)
      when 1000000..999999999999999 then gazillions(levs, feminine)
      else
        too_big
    end
  end

  def self.below_hundred(digits, feminine=nil)
    case digits
    when 1..19 then basic_number(digits, feminine)
    when 20..99 then round_ten(digits, feminine)
    end
  end

  def self.basic_number(digits, feminine=nil)
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

  def self.round_ten(digits, feminine=nil)
    second_digit = digits.to_s.reverse.chr.to_i
    output = basic_number(digits.to_s[0].to_i)+"десет"
    output += " и " + basic_number(second_digit, feminine) unless second_digit == 0
    return output
  end

  def self.hundreds(digits, feminine=nil)
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
    output += " " + levs_slovom(final_digits, feminine) unless final_digits == 0
    return output.gsub(/\s+/, " ").strip
  end

  def self.thousands(digits, feminine=nil)
    count = digits.to_s.length
    case count
      when 4 then
        small = digits.to_s[0].to_i
        small == 1 ? hh = "хиляда " : hh = levs_slovom(small, feminine = true) + " хиляди "
        big = digits.to_s[1..3].to_i
      when 5 then
        small = digits.to_s[0..1].to_i
        hh = levs_slovom(small, feminine = true) + " хиляди "
        big = digits.to_s[2..4].to_i
      when 6 then
        small = digits.to_s[0..2].to_i
        hh = levs_slovom(small, feminine = true) + " хиляди "
        big = digits.to_s[3..5].to_i
    end
    output = hh
    output += " и " unless (levs_slovom(big).include?(" и ") && big.to_s.length == 3) or levs_slovom(big) == "много"
    output += levs_slovom(big) unless big == 0
    return output.gsub(/\s+/, " ").strip
  end

  def self.gazillions(digits, feminine=nil)
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

    output = levs_slovom(big_number) + word
    output += " и " unless levs_slovom(small_number).include? " и " or levs_slovom(small_number) == "много"
    output += levs_slovom(small_number) unless levs_slovom(small_number) == "много"
    return output.gsub(/\s+/, " ").strip
  end
end
