# frozen_string_literal: true

Then 'I should be on the Dashboard page' do
  within 'header' do
    expect(page).to have_link('Dashboard')
  end
end

Given 'I am on the home page' do
  visit_comm100
end
