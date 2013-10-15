class MessagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def show
    message = Message.find(params[:id])
    render status: 200, json: message
  end

  private

  def render_404
    render status: 404, nothing: true
  end
end
