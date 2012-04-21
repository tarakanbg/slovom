#encoding: utf-8
require 'bigdecimal'
require 'spec_helper.rb'
# require 'slovom'

describe BigDecimal do

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
  end

end
