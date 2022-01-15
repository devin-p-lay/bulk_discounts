require 'rails_helper'

describe 'edit merchant discount' do
  before do
    @merchant = Merchant.create(name: "Devin's")
    @discount = Discount.create(name: '10 at 10', percentage_discount: 10, quantity_threshold: 10, merchant_id: @merchant.id)
    visit edit_merchant_discount_path(@merchant, @discount)
  end

  it 'form to edit discount pre-populated with current attributes' do
    expect(page).to have_field('Name', with: @discount.name)
    expect(page).to have_field('Discount Percentage', with: @discount.percentage_discount)
    expect(page).to have_field('Quantity Threshold', with: @discount.quantity_threshold)
    fill_in :name, with: '15 at 15'
    fill_in :percentage_discount, with: 15
    fill_in :quantity_threshold, with:15
    click_on 'Submit'
    expect(current_path).to eq(merchant_discount_path(@merchant, @discount))
    expect(page).to have_content('15 at 15')
    expect(page).to_not have_content('10 at 10')
  end
end 