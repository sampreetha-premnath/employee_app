class PersonalController < ApplicationController

  def show
    byebug
    @personal = Personal.find(params[:id])
  end

  def new
    @personal = Personal.new
  end

  def create
    @personal = Personal.new(params[:personals])
    if @personal.save
      redirect_to :action => 'show'
    else
      render :action => 'new'
    end
  end
end