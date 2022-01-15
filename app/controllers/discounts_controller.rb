class DiscountsController < ApplicationController
  before_action :do_merchant, only: [:index, :create, :destroy]
  def index
    @discounts = @merchant.discounts
  end

  def show
    # @discount = Discount.find(params[:id])
  end

  def new
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

  def destroy
    Discount.find(params[:id]).destroy
    redirect_to merchant_discounts_path(@merchant)
  end

    private

      def discount_params
        params.permit(:name, :percentage_discount, :quantity_threshold)
      end
end