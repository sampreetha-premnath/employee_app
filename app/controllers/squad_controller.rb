class SquadController < ApplicationController
  def new
    @squad = Squad.new
  end

  def create
    @squad = Squad.new(params[:squads])
    if @squad.save
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def list
    @squads = Squad.all
  end

end
