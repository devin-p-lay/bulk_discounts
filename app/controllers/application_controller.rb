class ApplicationController < ActionController::Base
  def do_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
