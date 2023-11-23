require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @category = Category.create(name: "some_category")
  end

  describe 'Product Validations' do
    it "Should create a product with all four columns inserted" do
      @product = Product.create(name: "Some plant", description: "green", price: 600, quantity: 2, category: @category)
      expect(@product).to be_valid
    end

    it "Should not create a product when the name has no value" do
      @product = Product.create(description: "green", price: 600, quantity: 2, category: @category)
      expect(@product).to_not be_valid
    end

    it "Should not create a product when the quantity has no value" do
      @product = Product.create(name: "plant", price: 600, category: @category)
      expect(@product).to_not be_valid
    end

    it "Should not create a product when the price has no value" do
      @product = Product.create(name: "plant", quantity: 2, category: @category)
      expect(@product).to_not be_valid
    end

    it "Should not create a product when the category has no value" do
      @product = Product.create(name: "plant", price: 600, quantity: 2)
      expect(@product).to_not be_valid
    end
  end
end