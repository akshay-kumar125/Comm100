# frozen_string_literal: true

require 'browserstack/local'
require 'capybara'
require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'selenium-webdriver'
require 'webdrivers'
require 'yaml'

TASK_ID = (ENV['TASK_ID'] || 0).to_i
CONFIG_NAME = ENV['CONFIG_NAME'] || 'single'

# Set the base url via the profile
server = ENV['SERVER'].nil? ? 'uat' : ENV['SERVER']
platform = ENV['EXEC_PLATFORM'].nil? ? 'desktop' : ENV['EXEC_PLATFORM']
user_agent = ENV['User_Agent'].nil? ? 'safari_iphone' : ENV['User_Agent']

CONFIG = YAML.safe_load(File.read(File.join(File.dirname(__FILE__), '../../config/config.yml')))

@useragent = CONFIG[user_agent]

case platform

when 'desktop'
  Capybara.register_driver :selenium do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome)
  end

  Capybara.default_driver = :selenium
  Capybara.run_server = false

when 'linux'
  # Typical "HD" sized desktop
  Capybara.register_driver :desktop do |app|
    require 'capybara/poltergeist'

    file_descriptor = IO.sysopen('/dev/null', 'w+')

    options = {
      phantomjs_logger: IO.new(file_descriptor),
      phantomjs_options: ['--ignore-ssl-errors=yes', '--disk-cache=false'],
      timeout: 360,
      js_errors: false,
      window_size: [1920, 1080],
      screen_size: [1920, 1080],
      page_settings: {
        userAgent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36'
      }
    }

    Capybara::Selenium::Driver.new(app, options)
  end

  # Selenium HUB (can use Firefox, or Chrome standalone instances)
  Capybara.register_driver :selenium do |_app|
    require 'selenium-webdriver'
    require 'webdrivers'

    profile = Selenium::WebDriver::Firefox::Profile.new

    profile['general.useragent.override'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.99 Safari/537.36'

    capabilities = Selenium::WebDriver::Remote::Capabilities.firefox(
      takesScreenshot: true,
      firefox_profile: profile
    )

    Capybara::Selenium::Driver.new(
      :remote,
      url: "http://#{ENV['HUB_HOST']}:#{ENV['HUB_PORT']}/wd/hub",
      browser: :chrome,
      desired_capabilities: capabilities
    )
  end

  Capybara.configure do |config|
    config.default_driver = :selenium
    config.default_max_wait_time = 5
    config.app_host = 'https://www.comm100.com/'
  end
end

# set path for screeshots
Capybara.save_path = 'screenshots'
Capybara::Screenshot.register_driver(:selenium_remote) do |driver, path|
  driver.browser.save_screenshot path.to_s
end

# rm timestamp from screeshots filename
Capybara::Screenshot.append_timestamp = false

# set custome -more descriptive screeshot file name
Capybara::Screenshot.register_filename_prefix_formatter(:cucumber) do |example|
  "/#{example.feature.name.gsub(%r{^.*/spec/}, '').tr(',', '').tr(' ', '-')}-screenshot_#{example.name.gsub(%r{^.*/spec/}, '').tr(',', '').tr(' ', '-').tr('/', '-')}"
end

Before do
  @server = server
  Capybara.page.current_window.resize_to(1260, 768)
end

World(Capybara)
