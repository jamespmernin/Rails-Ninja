class SenseisController < ApplicationController
  before_action :set_sensei, only: [:show, :update, :destroy]

  # GET 
  def index
    @dojo = Dojo.find(params[:dojo_id])
    @senseis = Sensei.where(dojo_id: @dojo.id)
    render json: @senseis, include: :dojo, status: :ok
  end

  # GET 
  def show
    render json: @sensei, include: :dojo, status: :ok
  end

  # POST 
  def create
    @dojo = Dojo.find(params[:dojo_id])
    @sensei = Sensei.new(sensei_params)

    if @sensei.save
      render json: @sensei, status: :created
    else
      render json: @sensei.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT
  def update
    @dojo = Dojo.find(params[:dojo_id])
    if @sensei.update(sensei_params)
      render json: @sensei
    else
      render json: @sensei.errors, status: :unprocessable_entity
    end
  end

  # DELETE
  def destroy
    @sensei.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sensei
      @sensei = Sensei.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sensei_params
      params.require(:sensei).permit(:name, :image_url, :wise_quote)
    end
end