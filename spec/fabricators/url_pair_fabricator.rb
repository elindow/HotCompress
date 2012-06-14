Fabricator(:url_pair) do
	long_url { Fabricate.sequence(:long_url) { |i| "long_url #{i}" } }
	short_url { Fabricate.sequence(:short_url) { |i| "short_url #{i}" } }

end	