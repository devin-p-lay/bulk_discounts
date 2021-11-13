require 'rails_helper'

RSpec.describe "New Discount Page" do
  before do
    @merchant = Merchant.create!(name: 'Home Goods')
    visit new_merchant_discount_path(@merchant)
  end

  describe "when i visit a create new discount page" do
    describe "i fill out the form and click submit" do
      it "takes me to merchant discount index page; shows new discount" do
        fill_in :name, with: '25% OFF'
        fill_in :percentage_discount, with: 25
        fill_in :quantity_threshold, with: 200
        click_on 'Submit'
        expect(current_path).to eq(merchant_discounts_path(@merchant))
        expect(page).to have_content('25% OFF')
        expect(page).to have_content(25)
        expect(page).to have_content(200)
      end
    end
  end
end