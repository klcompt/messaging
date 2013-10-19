class MessagesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def index
    messages = Message.order('title ASC')
    render status: 200, json: messages
  end

  def show
    message = Message.find(params[:id])
    render status: 200, json: message
  end

  def create
    message = Message.new(message_params)
    if message.save
      render status: 201, json: message
    else
      render status: 422, json: { errors: message.errors.full_messages }
    end
  end

  def update
    message = Message.find(message_id)
    if message.update_attributes(message_params)
      render status: 204, nothing: true
    else
      render status: 422, json: { errors: message.errors.full_messages }
    end
  end

  private

  def message_id
    params[:id]
  end

  def message_params
    params.require(:message).permit(:title, :body, :rescended)
  end

  def render_404
    render status: 404, nothing: true
  end
end
