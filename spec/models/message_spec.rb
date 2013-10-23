require 'spec_helper'

describe Message do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should have_many(:message_logs) }

  describe '#active scope' do
    let!(:active_message1) { FactoryGirl.create :message }
    let!(:rescinded_message1) { FactoryGirl.create :message, rescinded: true }
    let!(:active_message2) { FactoryGirl.create :message }
    let!(:rescinded_message2) { FactoryGirl.create :message, rescinded: true }
    let!(:active_message3) { FactoryGirl.create :message }

    it 'has 5 total messages' do
      Message.unscoped.count.should == 5
    end

    it 'returns only the three active messages' do
      messages = Message.active.all
      messages[0].should == active_message1
      messages[1].should == active_message2
      messages[2].should == active_message3
    end
  end

  describe '#as_json' do
    let(:called_at) { 1.day.ago }
    let(:from) { "123-456-7890" }
    let!(:message) { FactoryGirl.create :message }
    let!(:message_log) { message.message_logs.create called_at: called_at, from: from }

    it 'adds message call_count' do
      message.as_json.should == {
        "id" => message.id,
        "title" => message.title,
        "body" => message.body,
        "created_at" => message.created_at,
        "updated_at" => message.updated_at,
        "rescinded" => false,
        "call_count" => 1 }
    end
  end
end
