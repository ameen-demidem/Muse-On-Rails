class StripeController < ApplicationController

  # Connect current_user's Stripe account to application.
  def oauth
    connector = StripeOauth.new( current_user )
    url, error = connector.oauth_url( redirect_uri: stripe_confirm_url )

    if url.nil?
      flash[:error] = error
      redirect_to teacher_students_path
    else
      redirect_to url
    end
  end

  # Confirm connection to current_user's Stripe account.
  def confirm
    connector = StripeOauth.new( current_user )
    if params[:code]
      connector.verify!( params[:code] )
    elsif params[:error]
      flash[:error] = "Authorization request denied."
    end

    redirect_to teacher_students_path
  end

  # Deauthorize application from current_user's Stripe account.
  def deauthorize
    connector = StripeOauth.new( current_user )
    connector.deauthorize!
    flash[:notice] = "Account disconnected from Stripe."
    redirect_to teacher_students_path
  end

end