require 'spec_helper'

describe 'Messages' do

  let!(:message) { FactoryGirl.create(:message) }

  describe 'get #show' do

    context 'message exists' do
      before { get message_path(message.id, format: :json) }

      it 'responds with 200' do
        response.status.should == 200
      end

      it 'returns JSON for the given global app' do
        parsed_json_response["title"].should == message.title
        parsed_json_response["body"].should == message.body
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
end
