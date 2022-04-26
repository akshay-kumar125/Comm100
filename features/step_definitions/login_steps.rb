# frozen_string_literal: true

#
# Steps for login/signup page interaction
#

When 'I try to log in using valid credentials' do
  step 'I wait 2 seconds'
  step 'I click on "Sign In"'
  step 'I log in with "xifehe9794@pantabi.com"'
  step 'I wait 3 seconds'
end

When 'I login with {string}' do |username|
  fill_in 'loginemail', with: username
  fill_in 'loginpassword', with: '1qaz!QAZ2wsx'
  find(:xpath, '//button[@id="lblLogin"]').click
  step 'I wait to see "Dashboard"'
  step 'I wait 2 seconds'
end

When 'I try to log in using the email {string} and password {string}' do |email, password|
  step 'I am on the home page'
  step 'I click on "Sign In"'
  fill_in 'loginemail', with: username
  fill_in 'loginpassword', with: password
  step 'I wait 2 seconds'
  find(:xpath, '//button[@id="lblLogin"]').click
end