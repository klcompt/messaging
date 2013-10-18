Given(/^some messages have been created$/) do
  @message1 = FactoryGirl.create(:message, title: 'Msg1', body: 'body contents1')
  @message2 = FactoryGirl.create(:message, title: 'Msg2', body: 'body contents2')
  @message3 = FactoryGirl.create(:message, title: 'Msg3', body: 'body contents3')
end

When(/^I visit the application$/) do
  visit root_url 
end

Then(/^I should see the messages$/) do
  within 'table.messages' do
    page.should have_content @message1.title
    page.should have_content @message1.body
    page.should have_content @message2.title
    page.should have_content @message2.body
    page.should have_content @message3.title
    page.should have_content @message3.body
  end
end

