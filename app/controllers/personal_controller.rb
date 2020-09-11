class PersonalController < ApplicationController

  def show
    @personal = Personal.find(params[:id]) if params[:id]
    @personal = Personal.where(employee_id: params[:employee_id]).first if params[:employee_id]
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
end