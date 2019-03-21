require 'rails_helper'

describe Product do
  describe '#create' do
    context "全ての要素が入っている時" do
      it "登録可能" do
        product = build(:product)
        expect(product).to be_valid
      end
    end

    context "指定の要素が空の時" do
      it "nameが空のため無効" do
        product = build(:product, name: "")
        product.valid?
        expect(product.errors[:name]).to include("can't be blank")
      end

      it "product_descriptionが空のため無効" do
        product = build(:product, product_description: "")
        product.valid?
        expect(product.errors[:product_description]).to include("can't be blank")
      end

      it "category1が空のため無効" do
        product = build(:product, category1: "")
        product.valid?
        expect(product.errors[:category1]).to include("can't be blank")
      end

      it "category2が空のため無効" do
        product = build(:product, category2: "")
        product.valid?
        expect(product.errors[:category2]).to include("can't be blank")
      end

      it "category3が空のため無効" do
        product = build(:product, category3: "")
        product.valid?
        expect(product.errors[:category3]).to include("can't be blank")
      end

      it "brandが空のため無効" do
        product = build(:product, brand: "")
        product.valid?
        expect(product.errors[:brand]).to include("can't be blank")
      end

      it "conditionが空のため無効" do
        product = build(:product, condition: "")
        product.valid?
        expect(product.errors[:condition]).to include("can't be blank")
      end

      it "postageが空のため無効" do
        product = build(:product, postage: "")
        product.valid?
        expect(product.errors[:postage]).to include("can't be blank")
      end

      it "shipping_methodが空のため無効" do
        product = build(:product, shipping_method: "")
        product.valid?
        expect(product.errors[:shipping_method]).to include("can't be blank")
      end

      it "ship_fromが空のため無効" do
        product = build(:product, ship_from: "")
        product.valid?
        expect(product.errors[:ship_from]).to include("can't be blank")
      end

      it "shipping_dateが空のため無効" do
        product = build(:product, shipping_date: "")
        product.valid?
        expect(product.errors[:shipping_date]).to include("can't be blank")
      end

      it "priceが空のため無効" do
        product = build(:product, price: "")
        product.valid?
        expect(product.errors[:price]).to include("can't be blank")
      end
    end
  end

  describe '#name length' do
    context "nameが40桁の時" do
      it "正しい" do
        product = FactoryBot.build(:product, name: "a" * 40)
        expect(product).to be_valid
      end
    end

    context "nameが41桁の時" do
      it "正しくない" do
        product = FactoryBot.build(:product, name: "a" * 41)
        expect(product).to be_invalid
      end
    end
  end

  describe '#product_description length' do
    context "product_descriptionが1000桁の時" do
      it "正しい" do
        product = FactoryBot.build(:product, product_description: "a" * 1000)
        expect(product).to be_valid
      end
    end

    context "product_descriptionが1001桁の時" do
      it "正しくない" do
        product = FactoryBot.build(:product, product_description: "a" * 1001)
        expect(product).to be_invalid
      end
    end
  end
end
