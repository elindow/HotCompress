Fabricator(:url_pair) do
	fname { Fabricate.sequence(:long_url) { |i| "long_url #{i}" } }
	lname { Fabricate.sequence(:short_url) { |i| "short_url #{i}" } }

end	