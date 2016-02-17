class SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :update, :destroy]

  # GET /schools
  # GET /schools.json
  def index
    @schools = School.all

    render json: @schools
  end

  # GET /schools/1
  # GET /schools/1.json
  def show
    render json: @school
  end

  # POST /schools
  # POST /schools.json
  def create
    @school = School.new(school_params)
    @school.classrooms ||= []  

    if @school.save
      render json: @school, status: :created, location: @school
    else
      render json: @school.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /schools/1
  # PATCH/PUT /schools/1.json
  def update
    @school = School.find(params[:id])

    if @school.update(school_params)
      head :no_content
    else
      render json: @school.errors, status: :unprocessable_entity
    end
  end

  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy
    @school.destroy

    head :no_content
  end

  private

    def set_school
      @school = School.find(params[:id])
    end

    def school_params
      params.require(:school).permit(:name, :ipads, :classrooms)
    end
end
