class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :discounts, through: :invoice_items

  enum status: [:cancelled, 'in progress', :complete]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def merchant_total_revenue
    wip = invoice_items.joins(item: :merchant).where('merchant_id = ?', merchant_ids)
    require "pry"; binding.pry
  end
end
