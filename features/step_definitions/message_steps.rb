Given(/^some messages have been created$/) do
  @message1 = FactoryGirl.create(:message, title: 'Msg1', body: 'body contents1')
  @message2 = FactoryGirl.create(:message, title: 'Msg2', body: 'body contents2')
  @message3 = FactoryGirl.create(:message, title: 'Msg3', body: 'body contents3')
end

When(/^I visit the application$/) do
  visit root_path
end

When(/^I create a new message$/) do
  @new_message_title = 'NewlyCreatedTitle'
  @new_message_body = 'Newly created message body.'
  within '#new_message' do
    fill_in 'messageTitle', with: @new_message_title
    fill_in 'messageBody', with: @new_message_body
    click_button('create')
  end
end

Then(/^I should see the new message as the last message in the list$/) do
  last_row = page.all('table.messages tr').last
  last_row.should have_content @new_message_title
  last_row.should have_content @new_message_body
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

