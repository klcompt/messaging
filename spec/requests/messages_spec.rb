require 'spec_helper'

describe 'Messages' do

  describe 'get #show' do

    context 'message exists' do
      let!(:message) { FactoryGirl.create(:message) }
      before { get message_path(message.id, format: :json) }

      it 'responds with 200' do
        response.status.should == 200
      end

      it 'returns JSON for the given global app' do
        parsed_json_response['title'].should == message.title
        parsed_json_response['body'].should == message.body
      end
    end

    context 'invalid id provided' do
      let(:invalid_id) { 999 }

      before { get message_path(invalid_id, format: :json) }

      it 'responds with 404' do
        response.status.should == 404
      end
    end
  end

  describe 'get #index' do

    context 'messages exist' do
      let!(:message1) { FactoryGirl.create(:message, title: 'Message 1', body: 'msg body 1') }
      let!(:message2) { FactoryGirl.create(:message, title: 'Message 2', body: 'msg body 2') }
      let!(:message3) { FactoryGirl.create(:message, title: 'Message 3', body: 'msg body 3') }

      before { get messages_path(format: :json) }

      it 'responds with 200' do
        response.status.should == 200
      end

      it 'returns json for all messages' do
        parsed_json_response.size.should == 3
        parsed_json_response[0]['title'].should == message1.title
        parsed_json_response[0]['body'].should == message1.body
        parsed_json_response[1]['title'].should == message2.title
        parsed_json_response[1]['body'].should == message2.body
        parsed_json_response[2]['title'].should == message3.title
        parsed_json_response[2]['body'].should == message3.body
      end
    end
  end
end
