require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.create(name: 'Electronics')
      @product = Product.new(name: 'Sample Product', price: 100, quantity: 10, category: @category)
    end

    it 'should save successfully with all four fields set' do
      expect(@product).to be_valid
    end

    it 'should not save without a name' do
      @product.name = nil
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not save without a price' do
      @product.price_cents = nil
      @product.save
      expect(@product.errors.full_messages).to include("Price cents is not a number")
      expect(@product.errors.full_messages).to include("Price is not a number")
    end

    it 'should not save without a quantity' do
      @product.quantity = nil
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not save without a category' do
      @product.category = nil
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
