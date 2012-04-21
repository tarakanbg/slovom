#encoding: utf-8
require "slovom/version"
require 'bigdecimal'
# require 'string'
# require 'integer'

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
    stotinki = stotinki+"0" if stotinki.length == 1
    stotinki = stotinki.to_i
    levs_title = levs_title(levs)
    stotinki_title = stotinki_title(stotinki)
    levs_slovom = levs_slovom(levs)
    stotinki_slovom = levs_slovom(stotinki, feminine=true)
    if stotinki_slovom.nil? || stotinki_slovom == "много"
      return levs_slovom + levs_title
    elsif levs_slovom.nil? || levs_slovom == "много"
      return stotinki_slovom + stotinki_title
    else
      return levs_slovom + levs_title + " и " + stotinki_slovom + stotinki_title
    end
  end

public
  def self.too_big
    "много"
  end

private

  def self.levs_title(levs)
    if levs == 1
      " лев"
    else
      " лева"
    end
  end

  def self.stotinki_title(stotinki)
    if stotinki == 1
      " стотинка"
    else
      " стотинки"
    end
  end

  def self.levs_slovom(levs, feminine=nil)
    case levs
      when 1..99 then below_hundred(levs, feminine)
      when 100..999 then hundreds(levs, feminine)
      when 1000..9999 then thousands(levs, feminine)
      when 10000..99999 then medium_thousands(levs, feminine)
      when 100000..999999 then big_thousands(levs, feminine)
      when 1000000..999999999 then millions(levs, feminine)
      when 1000000000..999999999999 then billions(levs, feminine)
      when 1000000000000..999999999999999 then trillions(levs, feminine)
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
    if feminine == true
      case digits
        when 1 then return "една"
        when 2 then return "две"
      end
    else
      case digits
        when 1 then return "един"
        when 2 then return "два"
      end
    end
    case digits
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
      when 13 then "тринадесет"
      when 14 then "четиринадесет"
      when 15 then "петнадесет"
      when 16 then "шестнадесет"
      when 17 then "седемнадесет"
      when 18 then "осемнадесет"
      when 19 then "деветнадесет"
      else
    end
  end

  def self.round_ten(digits, feminine=nil)
    second_digit = digits.to_s.reverse.chr.to_i
    case digits
      when 20 then "двадесет"
      when 30 then "тридесет"
      when 40 then "четиридесет"
      when 50 then "петдесет"
      when 60 then "шестдесет"
      when 70 then "седемдесет"
      when 80 then "осемдесет"
      when 90 then "деветдесет"
      when 21..29 then "двадесет и " + basic_number(second_digit, feminine)
      when 31..39 then "тридесет и " + basic_number(second_digit, feminine)
      when 41..49 then "четиридесет и " + basic_number(second_digit, feminine)
      when 51..59 then "петдесет и " + basic_number(second_digit, feminine)
      when 61..69 then "шестдесет и " + basic_number(second_digit, feminine)
      when 71..79 then "седемдесет и " + basic_number(second_digit, feminine)
      when 81..89 then "осемдесет и " + basic_number(second_digit, feminine)
      when 91..99 then "деветдесет и " + basic_number(second_digit, feminine)
      else
    end
  end

  def self.hundreds(digits, feminine=nil)
    final_digits = digits.to_s[1..3].to_i
    case digits
      when 100 then "сто"
      when 200 then "двеста"
      when 300 then "триста"
      when 400 then "четиристотин"
      when 500 then "петстотин"
      when 600 then "шестстотин"
      when 700 then "седемстотин"
      when 800 then "осемстотин"
      when 900 then "деветстотин"
      when 101..119 then "сто" + " и " + basic_number(final_digits, feminine)
      when 201..219 then "двеста" + " и " + basic_number(final_digits, feminine)
      when 301..319 then "триста" + " и " + basic_number(final_digits, feminine)
      when 401..419 then "четиристотин" + " и " + basic_number(final_digits, feminine)
      when 501..519 then "петстотин" + " и " + basic_number(final_digits, feminine)
      when 601..619 then "шестстотин" + " и " + basic_number(final_digits, feminine)
      when 701..719 then "седемстотин" + " и " + basic_number(final_digits, feminine)
      when 801..819 then "осемстотин" + " и " + basic_number(final_digits, feminine)
      when 901..919 then "деветстотин" + " и " + basic_number(final_digits, feminine)
      when 120..199 then "сто" + round_ten_andi(final_digits, feminine)
      when 220..299 then "двеста" + round_ten_andi(final_digits, feminine)
      when 320..399 then "триста" + round_ten_andi(final_digits, feminine)
      when 420..499 then "четиристотин" + round_ten_andi(final_digits, feminine)
      when 520..599 then "петстотин" + round_ten_andi(final_digits, feminine)
      when 620..699 then "шестстотин" + round_ten_andi(final_digits, feminine)
      when 720..799 then "седемстотин" + round_ten_andi(final_digits, feminine)
      when 820..899 then "осемстотин" + round_ten_andi(final_digits, feminine)
      when 920..999 then "деветстотин" + round_ten_andi(final_digits, feminine)
      else
    end
  end

  def self.round_ten_andi(digits, feminine=nil)
    second_digit = digits.to_s.reverse.chr.to_i
    if second_digit == 0
      " и " + round_ten(digits, feminine)
    else
      " " + round_ten(digits, feminine)
    end
  end

  def self.thousands(digits, feminine=nil)
    final_digits = digits.to_s[2..3].to_i
    final_three_digits = digits.to_s[1..3].to_i
    first_digit = digits.to_s.chr.to_i
    case digits
      when 1000 then "хиляда"
      when 1001..1999 then "хиляда " + evaluate_hundreds(final_three_digits)
      when 2000 then "две хиляди"
      when 2001..2999 then "две хиляди " + evaluate_hundreds(final_three_digits)
      else
        if final_three_digits == 0
          below_hundred(first_digit) + " хиляди"
        else
          below_hundred(first_digit) + " хиляди " + evaluate_hundreds(final_three_digits)
        end
    end
  end

  def self.evaluate_hundreds(digits)
    count = digits.to_s.length
    final_digits = digits.to_s[1..3].to_i if count == 3
    if final_digits == 0
      return "и "+ hundreds(digits)
    else
      if count == 2 || count == 1
        "и " + below_hundred(digits)
      elsif count == 3
        hundreds(digits)
      end
    end
  end

  def self.medium_thousands(digits, feminine=nil)
    first_two_digits = digits.to_s[0..1].to_i
    last_three_digits = digits.to_s[2..5].to_i
    if last_three_digits == 0
      below_hundred(first_two_digits, feminine=true) + " хиляди"
    else
      below_hundred(first_two_digits, feminine=true) + " хиляди " + evaluate_hundreds(last_three_digits)
    end
  end

  def self.big_thousands(digits, feminine=nil)
    first_three_digits = digits.to_s[0..2].to_i
    last_three_digits = digits.to_s[3..5].to_i
    if last_three_digits == 0
      hundreds(first_three_digits, feminine=true) + " хиляди"
    else
      hundreds(first_three_digits, feminine=true) + " хиляди " + evaluate_hundreds(last_three_digits)
    end
  end

  def self.millions(digits, feminine=nil)
    count = digits.to_s.length
    if count == 7
      millions = digits.to_s[0].to_i
      thousands = digits.to_s[1..12].to_i
    elsif count == 8
      millions = digits.to_s[0..1].to_i
      thousands = digits.to_s[2..12].to_i
    elsif count == 9
      millions = digits.to_s[0..2].to_i
      thousands = digits.to_s[3..12].to_i
    end
    milion_word = " милиона "
    milion_word = " милион " if millions == 1
    levs_slovom(millions) + milion_word + levs_slovom(thousands)
  end

  def self.billions(digits, feminine=nil)
    count = digits.to_s.length
    if count == 10
      billions = digits.to_s[0].to_i
      millions = digits.to_s[1..18].to_i
    elsif count == 11
      billions = digits.to_s[0..1].to_i
      millions = digits.to_s[2..18].to_i
    elsif count == 12
      billions = digits.to_s[0..2].to_i
      millions = digits.to_s[3..18].to_i
    end
    billion_word = " милиарда "
    billion_word = " милиард " if billions == 1
    levs_slovom(billions) + billion_word + levs_slovom(millions)
  end

  def self.trillions(digits, feminine=nil)
    count = digits.to_s.length
    if count == 13
      trillions = digits.to_s[0].to_i
      billions = digits.to_s[1..24].to_i
    elsif count == 14
      trillions = digits.to_s[0..1].to_i
      billions = digits.to_s[2..24].to_i
    elsif count == 15
      trillions = digits.to_s[0..2].to_i
      billions = digits.to_s[3..24].to_i
    end
    trillion_word = " трилиона "
    trillion_word = " трилион " if trillions == 1
    levs_slovom(trillions) + trillion_word + levs_slovom(billions)
  end

end
