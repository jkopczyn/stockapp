class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :create]
  before_action :require_logged_in, except: :show

  # GET /users/:user_id/stocks
  def index
    @stocks = current_user.stocks
    Stock.update_prices(@stocks.reject do |stock| 
      Time.now - stock.updated_at < 1.minute
    end)
  end

  # GET /stocks/:id
  # GET /stocks/:id.json
  # GET /stocks/symbol/:ticker_symbol
  def show
  end

  # POST /stocks
  # POST /stocks.json
  def create
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
    if params[:id]
      @stock = Stock.find(params[:id])
    elsif params[:ticker_symbol]
      @stock = Stock.find_by_ticker_symbol(params[:ticker_symbol])
    end
    @stock.update_price if @stock and Time.now - @stock.updated_at > 1.minute 
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def stock_params
    params.require(:stock).permit(:ticker_symbol)
  end
end
