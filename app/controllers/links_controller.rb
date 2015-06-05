class LinksController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout "application"

  def save
    @original_url = params[:original_url]
    @campaign = params[:campaign]
  end

  def shorten_links

  	require 'bitly'

	Bitly.use_api_version_3

	Bitly.configure do |config|
	    config.api_version = 3
	    config.access_token = "ffd5218474395ec84ab3e310a3c630deed442b4e"
	end

	p '# Saving URL'
    p params["original_url"]
    original_url = URI.escape params["original_url"]

    p original_url

    if  original_url.include?("http://") || original_url.include?("https://")
    	puts "String already includes http:// or https://"
    else
    	original_url.insert(0, "http://")
	end

	p '# Saving Campaign'
	p params["campaign"]
	campaign = URI.escape params["campaign"]
	intermediate_campaign = campaign.split("%20")
	convert_campaign = intermediate_campaign.join("-")
	p convert_campaign

	source_free_boards = "free_boards"
	source_direct_outreach = "direct_outreach"
	source_client = "client"
	source_talent_pool_alert = "talent_pool_alert"
	source_social = "social"
	source_newsletter = "rework_newsletter"

	medium_website = "website"
	medium_email = "e-mail"
	medium_linked_in = "linked_in"
	medium_any = "any"
	medium_social_media = "social_media"

	content_job_boards = "job_boards"
	content_university_alum = "university_alum"
	content_consulting = "consulting"
	content_partner = "content_partner"
	content_linked_in = "linked_in"
	content_misc = "misc"
	content_any = "any"

	term_apply_link = "apply_link"
	term_dart_image = "apply_link"
	term_learn_more = "learn_more"
	term_logo = "logo"
	term_link = "link"

	link_1 = original_url + "/?utm_source=" + source_free_boards + "&utm_medium=" + medium_website + "&utm_content=" + content_job_boards + "&utm_campaign=" + convert_campaign
	link_2 = original_url + "/?utm_source=" + source_free_boards + "&utm_medium=" + medium_website + "&utm_content=" + content_university_alum + "&utm_campaign=" + convert_campaign
	link_3 = original_url + "/?utm_source=" + source_free_boards + "&utm_medium=" + medium_website + "&utm_content=" + content_consulting + "&utm_campaign=" + convert_campaign

	link_4 = original_url + "/?utm_source=" + source_direct_outreach + "&utm_medium=" + medium_email + "&utm_content=" + content_partner + "&utm_campaign=" + convert_campaign
	link_5 = original_url + "/?utm_source=" + source_direct_outreach + "&utm_medium=" + medium_linked_in + "&utm_content=" + content_linked_in + "&utm_campaign=" + convert_campaign
	link_6 = original_url + "/?utm_source=" + source_direct_outreach + "&utm_medium=" + medium_any + "&utm_content=" + content_misc + "&utm_campaign=" + convert_campaign

	link_7 = original_url + "/?utm_source=" + source_client + "&utm_medium=" + medium_any + "&utm_content=" + content_any + "&utm_campaign=" + convert_campaign

	link_8 = original_url + "/?utm_source=" + source_social + "&utm_medium=" + medium_social_media + "&utm_content=" + content_any + "&utm_campaign=" + convert_campaign

	link_9 = original_url + "/?utm_source=" + source_talent_pool_alert + "&utm_medium=" + medium_email + "&utm_content=" + content_any + "&utm_campaign=" + convert_campaign

	link_10 = original_url + "/?utm_source=" + source_newsletter + "&utm_medium=" + medium_email + "&utm_content=" + content_any + "&utm_campaign=" + convert_campaign


	array = []
	array += [link_1, link_2, link_3, link_4, link_5, link_6, link_7, link_8, link_9, link_10]

	short_array = array.map { |x| Bitly.client.shorten(x) }

	@list_of_data = []

	short_array.each do |x|
    my_link_data = {}
    
    first_split = x.long_url.split("=")
    source_split = first_split[1].split("&")
    source_title = source_split[0]
    content_split = first_split[3].split("&")
    content_title = content_split[0]
    full_descriptor = source_title.capitalize + " / " + content_title.capitalize
    p full_descriptor


    my_link_data["link_title"] = full_descriptor
    my_link_data["full_url"] = x.long_url
    my_link_data["shortened_url"] = x.short_url
    my_link_data["clicks"] = x.user_clicks

    @list_of_data.push my_link_data
    end

	p @list_of_data
end
end