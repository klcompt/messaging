require 'spec_helper'

describe Twilio::MessagesController do

  describe '#retrieve' do
    let(:message_id) { 'id' }
    let(:params) { { Digits: message_id } }
    let(:message) { double 'message' }
    let(:active_messages) { double 'active scope' }

    before do 
      Message.stub(:active) { active_messages }
      active_messages.stub(:where).with(id: message_id) { [ message ] }
      subject.stub(render: nil)
    end

    it 'should assign message_id' do
      post :retrieve, params

      assigns(:message_id).should == message_id 
    end

    it 'should assign message' do
      post :retrieve, params

      assigns(:message).should == message
    end
  end
end

