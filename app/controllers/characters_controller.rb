class CharactersController < ApplicationController
  before_action :authorize, only: [:show, :edit, :update, :destroy, :new, :create]
  before_action :authorize_admin, only: [:index]
  before_action :set_character, only: [:show, :edit, :update, :destroy]

  # GET /characters
  def index
    @characters = Character.all
  end

  def home
    if user_signed_in?
      @character = Character.by_user_id(current_user.id)
    end
  end

  # GET /characters/1
  def show
  end

  # GET /characters/new
  def new
    @character = Character.new
  end

  # GET /characters/1/edit
  def edit
  end

  # POST /characters
  def create
    cp = character_params
    cp[:hp] =  (12 - character_params[:damage].to_i) * 5
    @character = Character.new(cp)

    if @character.save
      redirect_to @character, notice: 'Character was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /characters/1
  def update
    if @character.update(character_params)
      redirect_to @character, notice: 'Character was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /characters/1
  def destroy
    @character.destroy
    redirect_to characters_url, notice: 'Character was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character
      @character = Character.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def character_params
      params.require(:character).permit(:name, :type, :hp, :damage, :user_id, :picked_up, :battled)
    end
end
