class ApplicationController < ActionController::Base
  protect_from_forgery

  def hello
    render text: "hi"
  end
end
