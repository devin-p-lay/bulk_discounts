require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "validations" do
    it { should validate_presence_of :invoice_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :quantity }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :status }
  end
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  end

  describe "class methods" do
    it 'incomplete_invoices' do
      @m1 = Merchant.create!(name: 'Merchant 1')
      @c1 = Customer.create!(first_name: 'Bilbo', last_name: 'Baggins')
      @c2 = Customer.create!(first_name: 'Frodo', last_name: 'Baggins')
      @c3 = Customer.create!(first_name: 'Samwise', last_name: 'Gamgee')
      @c4 = Customer.create!(first_name: 'Aragorn', last_name: 'Elessar')
      @c5 = Customer.create!(first_name: 'Arwen', last_name: 'Undomiel')
      @c6 = Customer.create!(first_name: 'Legolas', last_name: 'Greenleaf')
      @item_1 = Item.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10, merchant_id: @m1.id)
      @item_2 = Item.create!(name: 'Conditioner', description: 'This makes your hair shiny', unit_price: 8, merchant_id: @m1.id)
      @item_3 = Item.create!(name: 'Brush', description: 'This takes out tangles', unit_price: 5, merchant_id: @m1.id)
      @i1 = Invoice.create!(customer_id: @c1.id, status: 2)
      @i2 = Invoice.create!(customer_id: @c1.id, status: 2)
      @i3 = Invoice.create!(customer_id: @c2.id, status: 2)
      @i4 = Invoice.create!(customer_id: @c3.id, status: 2)
      @i5 = Invoice.create!(customer_id: @c4.id, status: 2)
      @ii_1 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
      @ii_2 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
      @ii_3 = InvoiceItem.create!(invoice_id: @i2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
      @ii_4 = InvoiceItem.create!(invoice_id: @i3.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 1)

      expect(InvoiceItem.incomplete_invoices).to eq([@i1, @i3])
    end

    describe '.discount_revenue' do
      it 'can return merchant discounted revenue' do
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

        expect(invoice.invoice_items.discount_revenue).to eq(4355)
      end
    end

    describe 'instance methods' do
      before do
        @customer = Customer.create(first_name: "My", last_name: "Customer")
        @invoice = @customer.invoices.create(status: 1)

        @merchant_a = Merchant.create(name: "Devin's")
        @item_a1 = Item.create(name: "item 1", description: 'description', unit_price: 10, merchant_id: @merchant_a.id)
        @item_a2 = Item.create(name: "item 2", description: 'description', unit_price: 10, merchant_id: @merchant_a.id)
        @invoice_item1 = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item_a1.id, quantity: 12, unit_price: 100, status: 1 )
        @invoice_item2 = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item_a2.id, quantity: 15, unit_price: 100, status: 1 )
        @discount_a1 = @merchant_a.discounts.create(name: 'Discount A', percentage_discount: 10, quantity_threshold: 10)
        @discount_a2 = @merchant_a.discounts.create(name: 'Discount B', percentage_discount: 15, quantity_threshold: 15)

        @merchant_b = Merchant.create(name: "Beckett's")
        @item_b = Item.create(name: "item 3", description: 'description', unit_price: 10, merchant_id: @merchant_b.id)
        @invoice_item3 = InvoiceItem.create!(invoice_id: @invoice.id, item_id: @item_b.id, quantity: 20, unit_price: 100, status: 1 )
      end

      describe '#revenue' do
        it 'can return the revenue of an invoice item' do
          expect(@invoice_item1.revenue).to eq(1200)
        end
      end

      describe '#best_deal' do
        it 'can find the most applicable discount' do
          expect(@invoice_item1.best_deal.name).to eq('Discount A')
          expect(@invoice_item2.best_deal.name).to eq('Discount B')
        end
      end

      describe '#discount_applied' do
        it 'can return discounted revenue of invoice item' do
          expect(@invoice_item1.discount_applied).to eq(1080)
        end
      end
    end
  end
end
