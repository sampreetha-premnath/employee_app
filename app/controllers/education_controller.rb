class EducationController < ApplicationController

  def show
    @education = Education.find(params[:id]) if params[:id]
    @education = Education.where(employee_id: params[:employee_id]).first if params[:employee_id]
    @employee = Employee.where(employee_id: params[:id])[0]
  end

  def new
    @education = Education.new
    @employee_id = params[:employee_id]
  end

  def create
    params[:educations][:employee_id] = params[:employee_id] if params[:employee_id].present?
    @education = Education.new(params[:educations])
    if @education.save
      redirect_to :action => 'show', :id => @education.id, :employee_id => @education.employee_id
    else
      render :action => 'new'
    end
  end

  def edit
    @education = Education.find(params[:id])
    @employee_id = params[:employee_id]
  end

  def update
    @education = Education.find(params[:id])

    @education.update_attributes(tenth_school: params[:tenth_school], tenth_grade: params[:tenth_grade],
                                 twelfth_school: params[:twelfth_school], twelfth_grade: params[:twelfth_grade],
                                 ug_university: params[:ug_university], ug_grade: params[:ug_grade])

    redirect_to edu_show_path(@education)
  end
end