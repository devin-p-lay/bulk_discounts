require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions}
  end
  describe "instance methods" do
    it "total_revenue" do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)

      expect(@invoice_1.total_revenue).to eq(100)
    end

    it '#invoice_items_by_merchant' do
      customer = Customer.create(first_name: "My", last_name: "Customer")
      invoice = customer.invoices.create(status: 1)

      merchant_a = Merchant.create(name: "Devin's")
      item_a1 = Item.create(name: "item 1", description: 'description', unit_price: 10, merchant_id: merchant_a.id)
      item_a2 = Item.create(name: "item 2", description: 'description', unit_price: 10, merchant_id: merchant_a.id)
      invoice_item1 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item_a1.id, quantity: 12, unit_price: 100, status: 1 )
      invoice_item2 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item_a2.id, quantity: 15, unit_price: 100, status: 1 )
      discount_a1 = merchant_a.discounts.create(name: 'Discount A', percentage_discount: 10, quantity_threshold: 10)
      discount_a2 = merchant_a.discounts.create(name: 'Discount B', percentage_discount: 15, quantity_threshold: 15)

      merchant_b = Merchant.create(name: "Beckett's")
      item_b = Item.create(name: "item 3", description: 'description', unit_price: 10, merchant_id: merchant_b.id)
      invoice_item3 = InvoiceItem.create!(invoice_id: invoice.id, item_id: item_b.id, quantity: 20, unit_price: 100, status: 1 )

      expect(invoice.invoice_items_by_merchant(merchant_a)).to eq([invoice_item1, invoice_item2])
    end
  end
end
