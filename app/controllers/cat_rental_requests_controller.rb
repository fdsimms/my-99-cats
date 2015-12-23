class CatRentalRequestsController < ApplicationController

  before_action :verify_cat_ownership, only: [:approve, :deny]

  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    @cat_rental_request.user_id = current_user.id if current_user

    if @cat_rental_request.save
      redirect_to cat_url(cat_rental_request_params[:cat_id])
    else
      render :new
    end
  end

  def approve
    @cat_rental_request.approve!
    redirect_to cat_url(@cat.id)
  end

  def deny
    @cat_rental_request.deny!
    redirect_to cat_url(@cat.id)
  end

  private

  def verify_cat_ownership
    @cat_rental_request = CatRentalRequest.find(params[:id])
    cat_id = @cat_rental_request.cat_id

    @cat = current_user.cats.find(cat_id) if current_user

    unless @cat
      flash[:errors] = "That's not your cat!"
      redirect_to cat_url(params[:id])
    end
  end

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end

end
