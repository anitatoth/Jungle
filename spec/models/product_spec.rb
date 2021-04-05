require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "should check it is valid" do
      @category = Category.new(name: "testCat")    
      @product = Product.create(name: "testProd", price_cents: 900, quantity: 10, category: @category)    
      expect(@product.errors).not_to include("can't be blank")  
    end

    it "should check it has name" do
      @category = Category.new(name: "testCat")    
      @product = Product.create(name: nil, price_cents: 900, quantity: 10, category: @category)    
      expect(@product.errors[:name]).to include("can't be blank") 
    end

    it "should check it has price" do
      @category = Category.new(name: "testCat")    
      @product = Product.create(name: "testProd", price_cents: nil, quantity: 10, category: @category)    
      expect(@product.errors[:price]).to include("can't be blank") 
  
    end
  
    it "should check has it has quantity" do
      @category = Category.new(name: "testCat")    
      @product = Product.create(name: "testProd", price_cents: 10, quantity: nil, category: @category)    
      expect(@product.errors[:quantity]).to include("can't be blank")
    end
  
    it "should check it has category" do
      @category = Category.new(name: "testCat")    
      @product = Product.create(name: "testProd", price_cents: 900, quantity: 10, category: nil)    
      expect(@product.errors[:category]).to include("can't be blank")
    end

  end
end