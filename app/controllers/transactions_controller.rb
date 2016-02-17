class TransactionsController < ApplicationController
  before_action :require_logged_in

  # GET /stocks/:stock_id/transactions/new
  def new
    @transaction = Transaction.new
  end

  # POST /stocks/:stock_id/transactions
  # POST /stocks/:stock_id/transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to current_user, notice: 'Transaction was successfully created.' }
        #format.json { render :show, status: :created}
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
      params.require(:transaction).permit(:quantity, :stock_id,
                                          :user_id, :transaction_type)
    end
end
