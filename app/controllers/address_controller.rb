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
    else
      render :action => 'new'
    end
  end

  def list
    byebug
    @addresses = Address.where(employee_id: params[:employee_id])
  end

  def show
    byebug
    @address = Address.find(params[:id])
    @employee = Employee.where(id: params[:employee_id])[0]
  end

  def edit
    @address = Address.find(params[:id])
    @employee_id = params[:employee_id]
  end

  def update
    @address = Address.find(params[:id])

    @address.update_attributes(first_line: params[:first_line], second_line: params[:second_line],
                               city: params[:city], pincode: params[:pincode], name: params[:name])

    redirect_to address_show_path(@address)
  end
end