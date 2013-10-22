class Twilio::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initiate
  end

  def retrieve
    @message_id = message_id
    @message = Message.active.where(id: message_id).first
  end

  private

  def message_id
    params['Digits']
  end
end


