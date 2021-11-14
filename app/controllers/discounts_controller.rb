class DiscountsController < ApplicationController
  before_action :do_merchant
  def index
    @discounts = @merchant.discounts
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
    @discount = Discount.new
  end

  def create
    discount = @merchant.discounts.create(discount_params)
    if discount.save
      redirect_to merchant_discounts_path(@merchant)
    else
      flash[:alert] = 'Unable to submit form: Missing Information'
      redirect_to new_merchant_discount_path(@merchant)
    end
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    discount = Discount.find(params[:id])
    if discount.update(discount_params)
      redirect_to merchant_discount_path(@merchant, discount)
    else
      redirect_to edit_merchant_discount_path(@merchant, discount)
    end
  end

  def destroy
    Discount.find(params[:id]).destroy
    redirect_to merchant_discounts_path(@merchant)
  end


  private
    def do_merchant
      @merchant = Merchant.find(params[:merchant_id])
    end

    def discount_params
      params.permit(:name, :percentage_discount, :quantity_threshold)
    end
end