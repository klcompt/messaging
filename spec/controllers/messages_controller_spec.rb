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

  describe '#create' do

    let(:param_hash) { { title: 'Title Test', body: 'body content' } }
    let(:params) { double('params') }

    before do
      params.stub_chain(:require, :permit) { param_hash }
      Message.stub(:new).with(param_hash) { message }
      subject.stub(params: params, render: nil)
    end

    context 'saves successfully' do
      let(:message) { double('message', save: true) }

      it 'calls save on message' do
        message.should_receive(:save)

        subject.create
      end

      it 'responds with 201' do
        subject.should_receive(:render).with(status: 201, json: message)

        subject.create
      end
    end

    context 'validation errors' do
      let(:message_errors_full_messages) { double 'message errors full messages' }
      let(:message) { double('message', save: false) }

      before do
        message.stub_chain(:errors, :full_messages) { message_errors_full_messages }
      end

      it 'responds with 422' do
        subject.should_receive(:render).with(status: 422, json: { errors: message_errors_full_messages })

        subject.create
      end
    end
  end
end
