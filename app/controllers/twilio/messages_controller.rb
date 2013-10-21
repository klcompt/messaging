class Twilio::MessagesController < ApplicationController
  def initiate
    logger.error "initiate called with#{ params.inspect}"
  end

  def retrieve
    logger.error "Retrieve called with#{ params.inspect}"
  end
end
