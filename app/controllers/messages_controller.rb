class MessagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  #respond_to :json

  def index
    messages = Message.order('title ASC')
    render status: 200, json: messages
  end

  def show
    message = Message.find(params[:id])
    render status: 200, json: message
  end

  private

  def render_404
    render status: 404, nothing: true
  end
end
