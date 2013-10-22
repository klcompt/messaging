require 'spec_helper'

describe Message do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

  describe '#active scope' do
    let!(:active_message1) { FactoryGirl.create :message }
    let!(:rescended_message1) { FactoryGirl.create :message, rescended: true }
    let!(:active_message2) { FactoryGirl.create :message }
    let!(:rescended_message2) { FactoryGirl.create :message, rescended: true }
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
end
