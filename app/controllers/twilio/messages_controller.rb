class Twilio::MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def initiate
    logger.error "initiate called with#{ params.inspect}"
  end

  def retrieve
    logger.error "Retrieve called with#{ params.inspect}"
  end
end
