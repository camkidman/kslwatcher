class ChargesController < ApplicationController

  def new
    @term_parameters = params[:term]
  end

  def create
    # Amount in cents
    @user = User.find_by_email(charges_params["user_email"])
    @amount = charges_params["amount"]

    unless @user.stripe_reference_id
      customer = Stripe::Customer.create(
          :email => charges_params["user_email"],
          :card  => params[:stripeToken]
      )
      @user.update_attribute :stripe_reference_id, customer.id
    end

    charge = Stripe::Charge.create(
        :customer    => @user.stripe_reference_id ? @user.stripe_reference_id : customer.id,
        :amount      => @amount,
        :description => 'Customer from KSL Notifications',
        :currency    => 'usd'
    )
    charges_params["terms"].each {|search_term| @user.search_terms.create(term: search_term)}

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end

  private

  def charges_params
    params.require(:charge).permit(:user_email, :stripeToken, :amount, :description, :terms => [])
  end

end
