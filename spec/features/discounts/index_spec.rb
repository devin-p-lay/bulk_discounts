require 'rails_helper'

describe 'discounts index' do
  before do
    @merchant = Merchant.create(name: 'Super Store')
    @other_merchant = Merchant.create(name: 'Other Store')
    @discount1 = Discount.create(name: "10 at 10", percentage_discount: 10, quantity_threshold: 10, merchant_id: @merchant.id)
    @discount2 = Discount.create(name: "15 at 15", percentage_discount: 15, quantity_threshold: 15, merchant_id: @merchant.id)
    @discount3 = Discount.create(name: "20 at 20", percentage_discount: 20, quantity_threshold: 20, merchant_id: @merchant.id)
    @other_discount = Discount.create(name: "5 at 5", percentage_discount: 5, quantity_threshold: 5, merchant_id: @other_merchant.id)

    visit merchant_discounts_path(@merchant)
  end

  describe 'display' do
    it 'discount name as a link to their show page' do
      expect(page).to have_content(@discount1.name)
      expect(page).to have_content(@discount2.name)
      expect(page).to have_content(@discount3.name)
      expect(page).to_not have_content(@other_discount.name)
    end

    it 'link to create a new discount' do
      click_link 'Create new discount'
      expect(current_path).to eq(new_merchant_discount_path(@merchant))
    end

    describe "next to each discount, i see a link to delete it" do
      it "when clicked, i'm redirected to index and i no longer see the discount" do
        within "#discount-#{@discount1.id}" do
          click_link 'Delete discount'
        end
        expect(current_path).to eq(merchant_discounts_path(@merchant))
        expect(page).to_not have_content(@discount1)
      end
    end
  end
end