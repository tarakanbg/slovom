#encoding: utf-8
require 'bigdecimal'
require 'spec_helper.rb'
#require 'string'
#require 'integer'

describe BigDecimal do

  describe "input" do
    it "rounds correctly" do
      input = BigDecimal.new("10.202")
      input.round(2).should eq(BigDecimal.new("10.20"))
      input.round(2).to_s.should eq(BigDecimal.new("10.20").to_s)
    end

    it "splits levs" do
      input = BigDecimal.new("10.20")
      levs = input.fix.to_i
      levs.should eq(10)
    end

    it "splits stotinki" do
      input = BigDecimal.new("10.20")
      stotinki = input.frac.to_s('F').gsub("0.", '')
      stotinki.should eq("2")
      stotinki = stotinki+"0" if stotinki.length == 1
      stotinki.should eq("20")
      stotinki = stotinki.to_i
      stotinki.should eq(20)
    end
  end

  describe ".slovom" do
    it "converts stotinki into a valid string" do
      number = BigDecimal.new("00.56")
      number.slovom.should eq("петдесет и шест стотинки")

      number = BigDecimal.new("00.05")
      number.slovom.should eq("пет стотинки")

      number = BigDecimal.new("00.12")
      number.slovom.should eq("дванадесет стотинки")

      number = BigDecimal.new("00.23")
      number.slovom.should eq("двадесет и три стотинки")

      number = BigDecimal.new("00.99")
      number.slovom.should eq("деветдесет и девет стотинки")
    end

    it "converts levs and stotinki combo into a valid string" do
      number = BigDecimal.new("1.56")
      number.slovom.should eq("един лев и петдесет и шест стотинки")

      number = BigDecimal.new("3.05")
      number.slovom.should eq("три лева и пет стотинки")

      number = BigDecimal.new("10.20")
      number.slovom.should eq("десет лева и двадесет стотинки")

      number = BigDecimal.new("20.30")
      number.slovom.should eq("двадесет лева и тридесет стотинки")

      number = BigDecimal.new("14.12")
      number.slovom.should eq("четиринадесет лева и дванадесет стотинки")

      number = BigDecimal.new("71.23")
      number.slovom.should eq("седемдесет и един лева и двадесет и три стотинки")

      number = BigDecimal.new("101.99")
      number.slovom.should eq("сто и един лева и деветдесет и девет стотинки")

      number = BigDecimal.new("514.76")
      number.slovom.should eq("петстотин и четиринадесет лева и седемдесет и шест стотинки")

      number = BigDecimal.new("1264.34")
      number.slovom.should eq("хиляда двеста шестдесет и четири лева и тридесет и четири стотинки")

      number = BigDecimal.new("5317.04")
      number.slovom.should eq("пет хиляди триста и седемнадесет лева и четири стотинки")

      number = BigDecimal.new("14000.15")
      number.slovom.should eq("четиринадесет хиляди лева и петнадесет стотинки")

      number = BigDecimal.new("78381.92")
      number.slovom.should eq("седемдесет и осем хиляди триста осемдесет и един лева и деветдесет и две стотинки")

      number = BigDecimal.new("132011.16")
      number.slovom.should eq("сто тридесет и две хиляди и единадесет лева и шестнадесет стотинки")

      number = BigDecimal.new("1783085.21")
      number.slovom.should eq("един милион седемстотин осемдесет и три хиляди и осемдесет и пет лева и двадесет и една стотинки")

      number = BigDecimal.new("11316081.07")
      number.slovom.should eq("единадесет милиона триста и шестнадесет хиляди и осемдесет и един лева и седем стотинки")

      number = BigDecimal.new("159354101.33")
      number.slovom.should eq("сто петдесет и девет милиона триста петдесет и четири хиляди сто и един лева и тридесет и три стотинки")

      number = BigDecimal.new("56237203102.71")
      number.slovom.should eq("петдесет и шест милиарда двеста тридесет и седем милиона двеста и три хиляди сто и два лева и седемдесет и една стотинки")

      number = BigDecimal.new("31804319906444.10")
      number.slovom.should eq("тридесет и един трилиона осемстотин и четири милиарда триста и деветнадесет милиона деветстотин и шест хиляди четиристотин четиридесет и четири лева и десет стотинки")
    end
  end

end
