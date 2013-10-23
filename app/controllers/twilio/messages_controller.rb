class Twilio::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initiate
  end

  def retrieve
    @message_id = message_id
    @message = Message.active.where(id: message_id).first
    create_message_log if @message
  end

  private

  def message_id
    params['Digits']
  end

  def create_message_log
    @message.message_logs.create( from: params['From'], called_at: Time.now )
  end
end


