class Campaign < ActiveRecord::Base
	has_many :bitly_links, :class_name => "BitlyLink"
end
