class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]

  # GET /users/:user_id/stocks
  def index
    @stocks = User.find(params[:user_id]).stocks
    Stock.update_prices(@stocks.reject do |stock| 
      Time.now - stock.updated_at < 1.minute
    end)
  end

  # GET /stocks/:id
  # GET /stocks/:id.json
  def show
    set_stock
  end

  # POST /stocks
  # POST /stocks.json
  def create
    set_stock

    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: 'Stock was successfully created.' }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      if stock_params[:id]
        @stock = Stock.find(stock_params[:id])
      elsif params[:ticker_symbol]
        @stock = Stock.find_by_ticker_symbol(stock_params[:ticker_symbol]
      end
      @stock.update_price unless Time.now - @stock.updated_at < 1.minute
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.require(:stock).permit(:ticker_symbol, :id)
    end
end
