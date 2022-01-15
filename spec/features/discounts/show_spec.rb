require 'rails_helper'

describe 'merchant discount show' do
  before do
    @merchant = Merchant.create(name: "Devin's")
    @discount = Discount.create(name: '10 at 10', percentage_discount: 10, quantity_threshold: 10, merchant_id: @merchant.id)
    visit merchant_discount_path(@merchant, @discount)
  end

  describe 'display' do
    it 'info' do
      expect(page).to have_content("you will save 10% on each of those items when you reach 10 of that same item")
    end
  end
end