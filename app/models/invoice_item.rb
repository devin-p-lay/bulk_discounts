class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item
  has_many :discounts, through: :merchant

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def revenue
    quantity * unit_price
  end

  def best_deal
    discounts.where('discounts.quantity_threshold <= ?', quantity)
             .select('discounts.*')
             .order(percentage_discount: :desc)
             .first
  end

  def discount_applied
    revenue * (1 - (best_deal.percentage_discount.to_f / 100) )
  end

  def self.discount_revenue
    self.sum do |invoice_item|
      if invoice_item.best_deal
        invoice_item.discount_applied
      else
        invoice_item.revenue
      end
    end
  end
end
