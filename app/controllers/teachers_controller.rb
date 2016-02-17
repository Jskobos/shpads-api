class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :update, :destroy]
  before_filter :authenticate_admin_from_token, only: [:create, :destroy]
  before_filter :authenticate_user_from_token, except: [:create, :destroy]

  # GET /teachers
  # GET /teachers.json
  def index
    @teachers = Teacher.all

    render json: @teachers
  end

  # GET /teachers/1
  # GET /teachers/1.json
  def show
    render json: @teacher
  end

  # POST /teachers
  # POST /teachers.json
  def create
    @teacher = Teacher.new(teacher_params)

    if @teacher.save
      render json: @teacher, status: :created, location: @teacher
    else
      render json: @teacher.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /teachers/1
  # PATCH/PUT /teachers/1.json
  def update
    @teacher = Teacher.find(params[:id])

    if @teacher.update(teacher_params)
      head :no_content
    else
      render json: @teacher.errors, status: :unprocessable_entity
    end
  end

  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    @teacher.destroy

    head :no_content
  end

  private

    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    def teacher_params
      params.require(:teacher).permit(:email, :password, :auth_token, :admin,
        :password_confirmation, :school_id, :name)
    end

    def authenticate_admin_from_token
      unless authenticate_with_http_token do |token, options|
        t = Teacher.find_by(auth_token: token)
        t.admin == true
      end
        render json: { error: 'Bad Token'}, status: 401
      end
    end
end
