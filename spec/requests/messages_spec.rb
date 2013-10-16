require 'spec_helper'

describe 'Messages' do

  describe 'GET #show' do

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
      let(:invalid_id) { -999 }

      before { get message_path(invalid_id, format: :json) }

      it 'responds with 404' do
        response.status.should == 404
      end
    end
  end

  describe 'GET #index' do

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

  describe 'POST #create' do

    before { post messages_path(format: :json), params }

    context 'valid message data' do
      let(:params) { { message: { title: 'Test Title', body: 'This one goes out to the one I love.' } } }

      it 'responds with 201' do
        response.status.should == 201
      end
    end

    context 'invalid message data' do
      let(:params) { { message: { title: '', body: '' } } }

      it 'responds with 422' do
        response.status.should == 422
      end

      it 'returns validation errors' do
        parsed_json_response['errors'].should == ["Title can't be blank", "Body can't be blank"]
      end
    end
  end
end
