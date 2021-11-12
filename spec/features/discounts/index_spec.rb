require 'rails_helper'

RSpec.describe "Discounts Index Page" do
  before do
    @merchant = Merchant.create!(name: "Witch's Coven")
    @discount1 = Discount.create!(name: "5% OFF", percentage_discount: 5, quantity_threshold: 10, merchant_id: @merchant.id)
    @discount2 = Discount.create!(name: "10% OFF", percentage_discount: 10, quantity_threshold: 25, merchant_id: @merchant.id)
    @discount3 = Discount.create!(name: "15% OFF", percentage_discount: 15, quantity_threshold: 50, merchant_id: @merchant.id)
    @discount4 = Discount.create!(name: "20% OFF", percentage_discount: 20, quantity_threshold: 100, merchant_id: @merchant.id)
    visit merchant_discounts_path(@merchant)
  end

  describe "when I visit a Discount Index Page" do
    it "I see a list of all discounts with their attributes" do
      within "#discount-#{@discount1.id}" do
        expect(page).to have_content(@discount1.name)
        expect(page).to have_content(@discount1.percentage_discount)
        expect(page).to have_content(@discount1.quantity_threshold)
      end
    end

    it "has a link to discount show page" do
      click_link "#{@discount1.name}"
      expect(current_path).to eq(merchant_discount_path(@merchant, @discount1))
    end
  end
end