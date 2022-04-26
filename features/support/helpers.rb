# frozen_string_literal: true

module Helpers
  def wait_until
    require 'timeout'

    Timeout.timeout(60) do
      sleep(0.1) until value = yield
      value
    end
  end

  def basic_auth(name, password)
    if page.driver.respond_to?(:basic_auth)
      page.driver.basic_auth(name, password)
    elsif page.driver.respond_to?(:basic_authorize)
      page.driver.basic_authorize(name, password)
    elsif page.driver.respond_to?(:browser) && page.driver.browser.respond_to?(:basic_authorize)
      page.driver.browser.basic_authorize(name, password)
    else
      raise 'I don\'t know how to log in!'
    end
  end

def visit_comm100
   @base_url = 'https://www.comm100.com/'
    visit @base_url
  end

def wait_until
  Timeout.timeout(20) do
    sleep(0.1) until value = yield
  end
end

World(Helpers)
