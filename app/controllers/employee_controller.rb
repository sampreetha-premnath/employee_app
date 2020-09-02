class EmployeeController < ApplicationController
  def list
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
    @squads = Squad.all
  end

  def employee_params
    #    params[:employees].permit(:employee_id, :employee_name, :employee_email)
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to :action => 'list'
    else
      @squads = Squad.all
      render :action => 'new'
    end
  end

  def edit
    @employee = Employee.find(params[:id])
    @squads = Squad.all
  end

  def employee_param
    #    params.require(:employee).permit(:title, :price, :subject_id, :description)
  end

  def update
    @employee = Employee.find(params[:id])

    if @employee.update_attributes(employee_param)
      redirect_to :action => 'show', :id => @employee
    else
      @squads = Squad.all
      render :action => 'edit'
    end

  end

  def delete
    Employee.find(params[:id]).destroy
    redirect_to :action => 'list'
  end

  def show_squads
    @squad = Squad.find(params[:id])
  end
end
