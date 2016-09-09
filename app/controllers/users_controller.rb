class UsersController < ApplicationController
  def new
    @teacher = User.new
  end

  def create
    @teacher = User.new(user_params.merge!(role: "T"))
    if @teacher.save
      redirect_to [:new, :session]
    else
      render :new
    end
  end

  def destroy
    #TODO implement the deletion of a user
  end

  def payment
    # renders payment.html.erb
  end

  def pay
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :plan => 'basic',
      :source => params[:stripeToken]
    )

    current_user.update_attribute(:stripe_token, customer.id)

    redirect_to teacher_students_path
  end

  def charge
    begin
      charge = Stripe::Charge.create({
        :amount => 2500,
        :currency => "cad",
        :source => params[:stripeToken]
        }, {:stripe_account => current_user.children.first.teacher.stripe_user_id}
      )

      flash[:notice] = "Charged successfully!"

    rescue Stripe::CardError => e
      error = e.json_body[:error][:message]
      flash[:error] = "Charge failed! #{error}"
    end
  end

  protected

  def user_params
    params.require(:user).permit(:name, :username, :password)
  end

end
