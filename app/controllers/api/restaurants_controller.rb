class Api::RestaurantsController < ApplicationController
  def index
    name = restaurant_params[:name]
    location = restaurant_params[:location_id]

    if location != "0" && name
      @restaurants = Location.find(restaurant_params[:location_id]).restaurants.where("LOWER(name) LIKE LOWER(?)", "%#{name}%")
    elsif location != "0"
      @restaurants = Location.find(restaurant_params[:location_id]).restaurants
    else name
      @restaurants = Restaurant.where("LOWER(name) LIKE LOWER(?)", "%#{name}%")
    end

    render :index
  end
  # http://localhost:3000/api/restaurants?restaurant[name]=mcdon&restaurant[location_id]=1

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      render :show
    else
      render json: @restaurant.errors.full_messages, status: 422
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])

    if current_user
      @favorited = current_user.favorites.where(restaurant_id: @restaurant.id)
    else
      @favorited = []
    end

    if @favorited.empty?
      @favorited = false
    else
      @favorited.first.id
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:id, :name, :location_id,
      :rating, :price, :hours, :description, :location)
  end

end
