class EmployeeController < ApplicationController

  def list
    @employees = Employee.all
  end

  def show
    byebug
    @employee = Employee.where(employee_id: params[:id])[0]
    @personal = Personal.where(employee_id: @employee.id)[0]
    @education = Education.where(employee_id: @employee.id)[0]
  end

  def new
    @employee = Employee.new
    @squads = Squad.all
  end

  def create
    @employee = Employee.new(params[:employees])
    if @employee.save
      redirect_to :action => 'list'
    else
      @squads = Squad.all
      render :action => 'new'
    end
  end

=begin
  def edit
    @employee = Employee.find(params[:id])
    @squads = Squad.all
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
=end
end
