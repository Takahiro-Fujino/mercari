require 'rails_helper'

describe ProductImage do
  describe '#create' do
    context "全ての要素が入っている時" do
      it "登録可能" do
        product = FactoryBot.create(:product)
        product_image = build(:product_image)
        expect(product_image).to be_valid
      end
    end

    context "指定の要素が空の時" do
      it "imageが空のため無効" do
        product_image = build(:product_image, product_image: "")
        product_image.valid?
        expect(product_image.errors[:product_image]).to include("can't be blank")
      end
    end
  end
end
