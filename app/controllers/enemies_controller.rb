class EnemiesController < ApplicationController
  before_action :authorize_admin
  before_action :set_enemy, only: [:show, :edit, :update, :destroy]


  # GET /enemies
  def index
    @enemies = Enemy.all
  end

  # GET /enemies/1
  def show
  end

  # GET /enemies/new
  def new
    @enemy = Enemy.new
  end

  # GET /enemies/1/edit
  def edit
  end

  # POST /enemies
  def create
    @enemy = Enemy.new(enemy_params)
    if @enemy.save
      redirect_to @enemy, notice: 'Enemy was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /enemies/1
  def update
    if @enemy.update(enemy_params)
      redirect_to @enemy, notice: 'Enemy was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /enemies/1
  def destroy
    @enemy.destroy
    redirect_to enemies_url, notice: 'Enemy was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enemy
      @enemy = Enemy.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def enemy_params
      params.require(:enemy).permit(:name, :hp, :damage, :location_id, :enemy_photo)
    end
end
