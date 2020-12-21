class QualificationsController < ApplicationController
  before_action :authenticate_user!
  require 'mechanize'
  def schedule
    agent = Mechanize.new
    page = agent.get("https://www.takagiya.to/denki/sikaku/shiken_info.html")
    @elements = page.search('td')
  end
end
