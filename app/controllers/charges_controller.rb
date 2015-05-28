class ChargesController < ApplicationController

  def new
  end

  def create
    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create(params[:user_data])
    #     :email => 'example@stripe.com',
    #     :card  => params[:stripeToken]
    # )

    charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

  private

  def charges_params
    params.require(:charge).permit(:user_email, :stripeToken, :amount, :description)
  end

end
