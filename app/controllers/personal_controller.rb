class PersonalController < ApplicationController

  def show
    @personal = Personal.find(params[:id]) if params[:id]
    @personal = Personal.where(employee_id: params[:employee_id]).first if params[:employee_id]
    @employee = Employee.where(employee_id: params[:id])[0]
  end

  def new
    @personal = Personal.new
    @employee_id = params[:employee_id] 
  end

  def create
    params[:personals][:employee_id] = params[:employee_id] if params[:employee_id].present?
    @personal = Personal.new(params[:personals])
    if @personal.save
      redirect_to :action => 'show', :id => @personal.id, :employee_id => @personal.employee_id
    else
      render :action => 'new'
    end
  end

  def edit
    @personal = Personal.find(params[:id])
    @employee_id = params[:employee_id]
  end

  def update
    @personal = Personal.find(params[:id])

    @personal.update_attributes(first_name: params[:first_name], last_name: params[:last_name],
                                dob: params[:dob], gender: params[:gender],
                                nativity: params[:nativity], phone_number: params[:phone_number],
                                work_number: params[:work_number])

    redirect_to personal_show_path(@personal)

  end
end