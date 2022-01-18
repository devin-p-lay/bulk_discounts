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
  end

  it 'can handle form filled out incorrectly' do
    fill_in :name, with: nil
    fill_in :percentage_discount, with: nil
    fill_in :quantity_threshold, with: nil
    click_on 'Submit'
    expect(current_path).to eq(new_merchant_discount_path(@merchant))
    expect(page).to have_content("Unable to Create Discount")
  end
end