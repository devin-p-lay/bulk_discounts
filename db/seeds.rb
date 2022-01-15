
@merchant = Merchant.create(name: "Devin's")
@discount1 = Discount.create(name: "10 at 10", percentage_discount: 10, quantity_threshold: 10, merchant_id: @merchant.id)
@discount2 = Discount.create(name: "15 at 15", percentage_discount: 15, quantity_threshold: 15, merchant_id: @merchant.id)
@discount3 = Discount.create(name: "20 at 20", percentage_discount: 20, quantity_threshold: 20, merchant_id: @merchant.id)
