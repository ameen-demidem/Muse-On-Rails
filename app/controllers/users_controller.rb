class UsersController < ApplicationController
  def new
    @teacher = User.new
  end

  def create
    @teacher = User.new(user_params.merge!(role: "T"))
    if @teacher.save
      
      if !@teacher[:email].nil?
        NotificationMailer.welcome(@teacher).deliver
      end

      redirect_to [:new, :session]
    else
      render :new
    end
  end

  def edit
    @teacher = User.find(params[:id])
  end

  def update
    @teacher = User.find(params[:id])

    if @teacher.update_attributes(user_params)
      redirect_to users_subscribe_path
    else
      render :edit
    end
  end

  def destroy
    #TODO implement the deletion of a user
  end

  def payment
    # renders payment.html.erb
  end

  def subscribe
    subscription = Stripe::Subscription.retrieve(current_user.stripe_token)
    subscription.plan = current_user.plan
    subscription.save

    redirect_to teacher_students_path, notice: "Update successful!"
  end

  def pay
    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :plan => current_user.plan,
      :source => params[:stripeToken]
    )

    sub_id = customer.subscriptions.data

    current_user.update_attribute(:stripe_token, sub_id[0].id)

    redirect_to teacher_students_path
  end

  def charge
    begin
      charge = Stripe::Charge.create({
        :amount => (current_user.children.first.teacher.rate * 100),
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
    params.require(:user).permit(:name, :username, :password, :email, :rate, :plan)
  end

end
