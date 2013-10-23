require 'spec_helper'

describe MessageLog do
  describe 'attributes' do
    let(:called_at) { 1.day.ago }
    let(:from) { '314-222-2345' }
    let!(:message_id) { 112 }

    it 'has correct fields' do
      log = MessageLog.new(called_at: called_at, from: from, message_id: message_id)
      log.called_at.should == called_at
      log.from.should == from
      log.message_id.should == message_id
    end
  end
end
