class CampaignsController < ApplicationController

  def show_one
  	@campaign = Campaign.find(params['id'])

  	@all_links = []

  	@campaign.bitly_links.each do |b|
  		# stats = Bitly.client.info(b.short_url)
  		# sleep(1)
  		lookup  = Bitly.client.expand(b.short_url)
  		e = {}

		first_split = lookup.long_url.split("=")
	    source_split = first_split[1].split("&")
	    source_title = source_split[0]
	    content_split = first_split[3].split("&")
	    content_title = content_split[0]
	    full_descriptor = source_title.capitalize + " / " + content_title.capitalize
	    p full_descriptor
    	e["full_descriptor"] = full_descriptor

  		e["short_url"] = lookup.short_url
  		e["our_clicks"] = lookup.user_clicks
  		e["long_url"] = lookup.long_url
  		p lookup.long_url
  		# e["creator"] = lookup.created_by
  		@all_links.push e
  	end
  	
	# bitly.stats('http://bit.ly/wQaT')

  end

  def show
  end

  def update
  end

  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.destroy
    redirect_to root_path
  end
end
