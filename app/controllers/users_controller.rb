class UsersController < ApplicationController
  before_action :require_logged_out, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  # GET /users/:id
  # GET /users/:id.json
  def show
  end

  # GET /transactions/:id/edit
  def edit
  end

  # PATCH/PUT /transactions/:id
  # PATCH/PUT /transactions/:id.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end


  private
  def user_params
    params.require(:user).permit(:email, :password, :session_token)
  end
end
