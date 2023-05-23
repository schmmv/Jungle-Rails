require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'successfully saves a product with name, price, quantity, and category' do
      @category = Category.create(name: 'test_category')
      @product = Product.create(
        name: 'test',
        price: 20,
        quantity: 3,
        category: @category
      )
      expect(@product).to be_valid
    end
    it 'has a name' do
      @category = Category.create(name: 'test_category')
      @product = Product.create(
        name: nil,
        price: 20,
        quantity: 2,
        category: @category
      )
      # puts @product.errors.full_messages
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it 'has a price' do
      @category = Category.create(name: 'test_category')
      @product = Product.create(
        name: 'test_product',
        price: '',
        quantity: 3,
        category: @category
      )
      #  puts @product.inspect
      expect(@product.errors.full_messages).to include("Price is not a number")
    end
    it 'has a quantity' do
      @category = Category.create(name: 'test_category')
      @product = Product.create(
        name: 'test_product',
        price: 10,
        quantity: nil,
        category: @category
      )
      #  puts @product.inspect
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'has a category' do
      
      @product = Product.create(
        name: 'test_product',
        price: 10,
        quantity: 5,
        category: nil
      )
      #  puts @product.inspect
      expect(@product.errors.full_messages).to include("Category must exist")
    end
  end
end
