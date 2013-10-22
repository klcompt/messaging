require 'spec_helper'

describe 'Messages' do

  describe 'POST #initiate' do

    it 'responds with correct xml' do
      post twilio_messages_initiate_path(format: :xml)

      response.body.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<Response>\n  <Gather action=\"http://warm-oasis-2175.herokuapp.com/twilio/messages/retrieve\" numDigits=\"5\">\n    <Say>Welcome to The Messaging Center.</Say>\n    <Say>Please enter your message id and then press pound.</Say>\n  </Gather>\n  <!-- If customer doesn't input anything, prompt and try again. -->\n  <Say>Sorry, I didn't get your response.</Say>\n  <Pause/>\n  <Redirect>http://warm-oasis-2175.herokuapp.com/twilio/messages/initiate</Redirect>\n</Response>\n" 
    end
  end

  describe 'POST #initiate' do

    before { post twilio_messages_retrieve_path(format: :xml), params }

    context 'Active Message ID provided' do
      let!(:message) { FactoryGirl.create :message, body: 'TESTING BODY' }
      let(:params) { { 'Digits' => message.id } }

      it 'responds with correct xml' do
        post twilio_messages_retrieve_path(format: :xml), params

        response.body.should == "<?xml version='1.0' encoding='utf-8' ?>\n<Response>\n<Say>\nMessage text is, TESTING BODY.\n</Say>\n<Pause></Pause>\n<Redirect>\nhttp://warm-oasis-2175.herokuapp.com/twilio/messages/initiate\n</Redirect>\n</Response>\n"
      end
    end

    context 'Rescended Message ID provided' do
      let!(:message) { FactoryGirl.create :message, body: 'TESTING BODY', rescended: true }
      let(:params) { { 'Digits' => message.id } }

      it 'responds with correct xml' do
        post twilio_messages_retrieve_path(format: :xml), params

        response.body.should == "<?xml version='1.0' encoding='utf-8' ?>\n<Response>\n<Say>\nYour request was received, however, message id #{message.id} was not found.\n</Say>\n<Redirect>\nhttp://warm-oasis-2175.herokuapp.com/twilio/messages/initiate\n</Redirect>\n</Response>\n" 
      end
    end
  end
end
