require 'rails_helper'

RSpec.describe "Discount Edit Page" do
  before do
    @merchant = Merchant.create!(name: "Hippo 7")
    @discount = Discount.create!(name: "3% OFF", percentage_discount: 3, quantity_threshold: 9, merchant_id: @merchant.id)
    visit edit_merchant_discount_path(@merchant, @discount)
  end

  describe "when i visit a discount edit page" do
    describe "i see a form with current attributes pre-populated" do
      it "when i change any/all of the info and click submit, i'm redirected to discount show page with attributes updated" do
        fill_in :name, with: '5% OFF'
        fill_in :percentage_discount, with: 5
        fill_in :quantity_threshold, with: 10
        click_on 'Submit'
        expect(current_path).to eq(merchant_discount_path(@merchant, @discount))
        expect(page).to have_content('5% OFF')
        expect(page).to have_content(5)
        expect(page).to have_content(10)
      end

      it "if i fill out the form incorrectly, i'm redirected back to edit page" do
        fill_in :name, with: ''
        fill_in :percentage_discount, with: 5
        fill_in :quantity_threshold, with: 10
        click_on 'Submit'
        expect(current_path).to eq(edit_merchant_discount_path(@merchant, @discount))
      end
    end
  end
end
