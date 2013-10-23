require 'spec_helper'

describe Twilio::MessagesController do

  describe '#retrieve' do
    let(:message_id) { 'id' }
    let(:params) { { Digits: message_id, From: '333-444-5555' } }
    let(:message_logs) { double 'message_logs', create: nil }
    let(:message) { double 'message', message_logs: message_logs }
    let(:active_messages) { double 'active scope' }
    let(:current_time) { double 'current time' }

    before do
      Message.stub(:active) { active_messages }
      active_messages.stub(:where).with(id: message_id) { [ message ] }
      subject.stub(render: nil)
      Time.stub(:now) { current_time }
    end

    it 'should assign message_id' do
      post :retrieve, params

      assigns(:message_id).should == message_id
    end

    it 'should assign message' do
      post :retrieve, params

      assigns(:message).should == message
    end

    it 'should create a message log entry' do
      message_logs.should_receive(:create).with(from: params[:From], called_at: current_time)

      post :retrieve, params
    end
  end
end

