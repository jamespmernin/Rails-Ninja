class DojosController < ApplicationController
  before_action :set_dojo, only: [:show, :update, :destroy]

  # GET 
  def index
    @dojos = Dojo.all

    render json: @dojos, include: :senseis, status: :ok
  end

  # GET 
  def show
    render json: @dojo
  end

  # POST 
  def create
    @dojo = Dojo.new(dojo_params)

    if @dojo.save
      render json: @dojo, status: :created, location: @dojo
    else
      render json: @dojo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT 
  def update
    if @dojo.update(dojo_params)
      render json: @dojo
    else
      render json: @dojo.errors, status: :unprocessable_entity
    end
  end

  # DELETE 
  def destroy
    @dojo.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dojo
      @dojo = Dojo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def dojo_params
      params.require(:dojo).permit(:name, :motto)
    end
end
