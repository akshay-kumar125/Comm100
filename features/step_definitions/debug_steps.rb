# frozen_string_literal: true

When 'capture a screenshot called {string}' do |filename|
  save_screenshot "screenshots/#{filename}.png"
end

And 'I wait {int} seconds' do |seconds|
  sleep seconds
end
