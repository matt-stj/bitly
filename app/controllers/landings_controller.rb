class LandingsController < ApplicationController
  def index
  	@all_campaigns = Campaign.all.as_json(:include=>:bitly_links)
  	#assign bitly links to variable and show in template (passing campaign to template, but not loading bitly links -load here to access on template)
  end
end

