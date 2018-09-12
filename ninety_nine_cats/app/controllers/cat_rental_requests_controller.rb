class CatRentalRequestsController < ApplicationController
  def index
    #@cat = Cat.find(params[:cat_id])
    @cat_rental_requests = CatRentalRequest.where(cat_id: params[:cat_id])
    render json: @cat_rental_requests
  end

  def show
    @cat_rental_request = CatRentalRequest.find(params[:id])
    render :show
  end

  def new
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def edit
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.find(params[:id])
    render :edit
  end

  def update
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.find(params[:id])
    if @cat_rental_request.update(cat_rental_request_params)
      redirect_to cat_rental_request_url(@cat_rental_request)
    else
      render :edit
    end
  end

  def create
    @cats = Cat.all
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    if @cat_rental_request.save
      redirect_to cat_rental_request_url(@cat_rental_request)
    else
      render :new
    end
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end

end
