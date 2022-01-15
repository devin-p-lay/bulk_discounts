require 'rails_helper'

describe 'new merchant discount' do
  before do
    @merchant = Merchant.create(name: "Devin's")
    visit new_merchant_discount_path(@merchant)
  end

  it 'form to create new discount' do
    fill_in :name, with: '25 at 25'
    fill_in :percentage_discount, with: 25
    fill_in :quantity_threshold, with: 25
    click_on 'Submit'
    expect(current_path).to eq(merchant_discounts_path(@merchant))
    expect(page).to have_content('25 at 25')
    expect(page).to have_content('Get 25% off when you reach 25 items')
    save_and_open_page
  end
end