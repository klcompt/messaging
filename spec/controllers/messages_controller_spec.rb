require 'spec_helper'

describe MessagesController do

  describe '#show' do
    let(:id) { 'id' }
    let(:params) { { id: id } }

    before do 
      subject.stub(render: nil)
    end

    context 'message found' do
      let(:message) { double 'message' }

      before do
        Message.stub(:find).with(id) { message }
      end

      it 'should render correct data' do
        subject.should_receive(:render).with(status: 200, json: message)

        get :show, params
      end
    end

    context 'message not found' do
      before do
        Message.stub(:find).with(id).and_raise( ActiveRecord::RecordNotFound )
      end

      it 'should render 404' do
        subject.should_receive(:render).with(status: 404, nothing: true)

        get :show, params
      end
    end
  end

  describe '#index' do
    let(:messages) { double 'messages' }

    before do 
      Message.stub(:order) { messages }
      subject.stub(render: nil)
    end

    it 'retrieves all ordered messages' do
      Message.should_receive(:order).with('title ASC')

      subject.index
    end

    it 'should render correct data' do
      subject.should_receive(:render).with(status: 200, json: messages)

      subject.index
    end

  end
end
