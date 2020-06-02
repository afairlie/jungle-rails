require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    before do
      @category = Category.new(name: 'Test Category')
    end

    it 'should save when all required fields are present' do
      @product = Product.new(name: 'Soap', price: 2000, quantity: 5, category: @category)
      @product.save

      expect(@product.id).to be_present
    end

    it 'should not save if name is blank' do
      @product = Product.new(name: nil, price: 2000, quantity: 5, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not save if price is blank' do
      @product = Product.new(name: 'Soap', price: nil, quantity: 5, category: @category)
      @product.save
      
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should not save if quantity is blank' do
      @product = Product.new(name: 'Soap', price: 2000, quantity: nil, category: @category)
      @product.save

      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not save if category is blank' do
      @product = Product.new(name: 'Soap', price: 2000, quantity: 5, category: nil)
      @product.save

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end