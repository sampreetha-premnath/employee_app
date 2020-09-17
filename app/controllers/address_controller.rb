class AddressController < ApplicationController
  def new
    @address = Address.new
    @employee_id = params[:employee_id]
  end

  def create
    params[:addresses][:employee_id] = params[:employee_id] if params[:employee_id].present?
    @address = Address.new(params[:addresses])
    if @address.save
      redirect_to :action => 'list', :id => @address.id, :employee_id => @address.employee_id
    end
  end

  def list
    byebug
    @addresses = Address.where(employee_id: params[:employee_id])
  end

  def show
    @address = Address.find(params[:id])
    @employee = Employee.where(id: params[:employee_id])[0]
  end
end