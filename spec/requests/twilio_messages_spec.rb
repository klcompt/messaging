require 'spec_helper'

describe 'Messages' do

  describe 'POST #initiate' do

    it 'responds with correct xml' do
      post twilio_messages_initiate_path(format: :xml)

      response.body.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<Response>\n  <Gather action=\"http://warm-oasis-2175.herokuapp.com/twilio/messages/retrieve\" numDigits=\"5\">\n    <Say>Welcome to The Messaging Center.</Say>\n    <Say>Please enter your message id and then press pound.</Say>\n  </Gather>\n  <!-- If customer doesn't input anything, prompt and try again. -->\n  <Say>Sorry, I didn't get your response.</Say>\n  <Pause/>\n  <Redirect>http://warm-oasis-2175.herokuapp.com/twilio/messages/initiate</Redirect>\n</Response>\n" 
    end
  end

  describe 'POST #retrieve' do

    before { post twilio_messages_retrieve_path(format: :xml), params }

    context 'Active Message ID provided' do
      let!(:message) { FactoryGirl.create :message, body: 'TESTING BODY' }
      let(:params) { { 'Digits' => message.id, 'From' => "123-456-7890" } }

      it 'responds with correct xml' do
        response.body.should == "<?xml version='1.0' encoding='utf-8' ?>\n<Response>\n<Say>\nMessage text is, TESTING BODY.\n</Say>\n<Pause></Pause>\n<Redirect>\nhttp://warm-oasis-2175.herokuapp.com/twilio/messages/initiate\n</Redirect>\n</Response>\n"
      end

      it 'adds a MessageLog entry for message' do
        message_logs = Message.find(message.id).message_logs

        message_logs.count.should == 1
        message_logs.first.from.should == params['From']
      end
    end

    context 'Rescinded Message ID provided' do
      let!(:message) { FactoryGirl.create :message, body: 'TESTING BODY', rescinded: true }
      let(:params) { { 'Digits' => message.id } }

      it 'responds with correct xml' do
        post twilio_messages_retrieve_path(format: :xml), params

        response.body.should == "<?xml version='1.0' encoding='utf-8' ?>\n<Response>\n<Say>\nYour request was received, however, message id #{message.id} was not found.\n</Say>\n<Redirect>\nhttp://warm-oasis-2175.herokuapp.com/twilio/messages/initiate\n</Redirect>\n</Response>\n" 
      end
    end
  end
end
