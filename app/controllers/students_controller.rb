class StudentsController < ApplicationController
  before_action :has_student, only: %i[edit_score]
  before_action :must_login, only: %i[show new edit create update destroy]
  before_action :set_student, only: %i[ show edit update destroy edit_score]

  # GET /students or /students.json
  def index
    @students = Student.all
  end

  # GET /students/1 or /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # GET /students/1/edit_score
  def edit_score
    session[:from] = "student"
    @s = @student
    @scorestudent = Score.where(student_id:@s.id)

    sum = 0
    max = 0
    @maxsub = ""
    @scorestudent.each do |i|
      if i.point > max 
        max = i.point
        @maxsub = i.subject
      end 
      sum += i.point
    end
    
    if @scorestudent.count == 0 
      @avg = sum
    else
      @avg = sum/@scorestudent.count
    end

    @empty = true
    if !@scorestudent.blank?
      @empty = false
    end
  end


  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to student_url(@student), notice: "Student was successfully created." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url, notice: "Student was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:name, :dob, :student_no, :class_year)
    end

    #Check id of student is correct?
    def has_student
      if Student.where(id: params[:id]).empty?
        redirect_to students_path, notice: 'Not has this id in database'  
      else
        return true
      end
    end
end
