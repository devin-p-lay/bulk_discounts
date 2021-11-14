require 'rails_helper'

RSpec.describe "Discount Show Page" do
  before do
    @merchant = Merchant.create!(name: "Hippo 7")
    @discount = Discount.create!(name: "5% OFF", percentage_discount: 5, quantity_threshold: 10, merchant_id: @merchant.id)
    visit merchant_discount_path(@merchant, @discount)
  end

  describe "when i visit a discount show page" do
    it "i see the discount's quantity threshold and percentage discount" do
      expect(page).to have_content(@discount.quantity_threshold)
      expect(page).to have_content(@discount.percentage_discount)
    end
  end
end