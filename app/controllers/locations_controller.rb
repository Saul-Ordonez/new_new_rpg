class LocationsController < ApplicationController
  before_action :authorize_admin, only: [:index, :new, :edit, :create, :update, :destroy]
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :set_character, only: [:show]

  # GET /locations
  def index
    @locations = Location.all
  end

  # GET /locations/1
  def show
    if params[:grab]
      @character.item_grab(params[:grab])
    end
    if params[:attack]
      @character.damage_enemy(params[:attack])
    end
    if @character.hp < 1 || params[:id] == '5' || params[:id] == '8'
      @character.destroy
      @character = nil
      render :dead
    end
    @enemies = Enemy.by_location(params[:id])
    @items = @location.items
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to @location, notice: 'Location was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /locations/1
  def update
    if @location.update(location_params)
      redirect_to @location, notice: 'Location was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /locations/1
  def destroy
    @location.destroy
    redirect_to locations_url, notice: 'Location was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_location
    @location = Location.find(params[:id])
  end

  def set_character
    @character = Character.by_user_id(current_user.id)[0]
  end

  # Only allow a trusted parameter "white list" through.
  def location_params
    params.require(:location).permit(:room, :description, :door)
  end
end
