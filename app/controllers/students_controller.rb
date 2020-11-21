class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :update, :destroy]

  # GET 
  def index
    @dojo = Dojo.find(params[:dojo_id])
    @sensei = Sensei.find(params[:sensei_id])
    @students = Student.where(sensei_id: @sensei.id)
    render json: @students, include: :sensei, status: :ok
  end

  # GET 
  def show
    render json: @student, include: :sensei, status: :ok
  end

  # POST 
  def create
    @dojo = Dojo.find(params[:dojo_id])
    @sensei = Sensei.find(params[:sensei_id])
    @student = Student.new(student_params)

    if @student.save
      render json: @student, status: :created
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT
  def update
    @dojo = Dojo.find(params[:dojo_id])
    @sensei = Sensei.find(params[:sensei_id])
    if @student.update(student_params)
      render json: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # DELETE
  def destroy
    @student.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def student_params
      params.require(:student).permit(:name, :age, :special_attack)
    end
end