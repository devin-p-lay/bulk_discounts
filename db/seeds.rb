
# @merchant = Merchant.create(name: "Devin's")
#
# @item1 = Item.create(name: "item 1", description: 'description', unit_price: 10, merchant_id: @merchant.id)
# @item2 = Item.create(name: "item 2", description: 'description', unit_price: 10, merchant_id: @merchant.id)
#
# @customer = Customer.create(first_name: "My", last_name: "Customer")
# @invoice1 = @customer.invoices.create(status: 1)
#
# @invoice_item1 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item1.id, quantity: 20, unit_price: 10, status: 1 )
# @invoice_item2 = InvoiceItem.create!(invoice_id: @invoice1.id, item_id: @item2.id, quantity: 9, unit_price: 10, status: 1 )
#
# @discount1 = Discount.create(name: "5 at 10", percentage_discount: 5, quantity_threshold: 10, merchant_id: @merchant.id)
# @discount2 = Discount.create(name: "10 Fifty", percentage_discount: 10, quantity_threshold: 50, merchant_id: @merchant.id)
# @discount3 = Discount.create(name: "20 at 1", percentage_discount: 20, quantity_threshold: 100, merchant_id: @merchant.id)

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
