class DiscountsController < ApplicationController
  before_action :do_merchant
  before_action :do_discount, only: [:show, :edit, :update]

  def index
    @discounts = @merchant.discounts
  end

  def show; end

  def edit; end

  def new
    @discount = Discount.new
  end

  def create
    discount = @merchant.discounts.create(discount_params)
    if discount.save
      redirect_to merchant_discounts_path(@merchant)
    else
      flash[:alert] = 'Unable to Create Discount'
      redirect_to new_merchant_discount_path(@merchant)
    end
  end

  def update
    @discount.update(discount_params)
    redirect_to merchant_discount_path(@merchant, @discount)
  end

  def destroy
    Discount.find(params[:id]).destroy
    redirect_to merchant_discounts_path(@merchant)
  end

    private

      def discount_params
        params.permit(:name, :percentage_discount, :quantity_threshold)
      end

      def do_discount
        @discount = Discount.find(params[:id])
      end
end