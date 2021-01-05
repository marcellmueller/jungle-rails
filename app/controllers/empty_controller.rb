class EmptyController < ApplicationController
  def show
    render params[:page]
  end
end

