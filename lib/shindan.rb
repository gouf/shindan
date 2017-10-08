require 'shindan/version'
require 'mechanize'

module Shindan
  class Scraper
    SHINDAN_URL = 'https://shindanmaker.com'.freeze

    def initialize(shindan_id, user_name)
      @user_name = user_name
      agent = Mechanize.new
      @page = agent.get("#{SHINDAN_URL}/#{shindan_id}")
    end

    def shindan
      shindan_result(filled_form)
    end

    private

    def filled_form
      form = @page.form_with(id: 'form')
      form.field_with(name: 'u') do |input|
        input.value = @user_name
      end
      form
    end

    def shindan_result(filled_form)
      page = filled_form.submit
      page.css('#copy_text_140').text
    end
  end
end
