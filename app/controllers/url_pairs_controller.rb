class UrlPairsController < ApplicationController

	def id
		if @guest_user
			@id = guest_user.id
		else
			if current_user.nil?
				@id = User.find_by_email("guest@e.com")
			else 
				@id = current_user.id
			end
		end
	end

	def index
		current_or_guest_user
		@url_pairs = User.find_by_id(@id).url_pairs.all
		@url_pairs.sort_by! { |s| s[:short_url]}
		if @id == guest_user.id
			puts "Logged in as guest"
		else
			puts "Logged in as #{current_user.email}"
		end
	end

	def show
		id
		@url_pair = UrlPair.find(params[:id])
	end

	def new
		id
		@url_pair = UrlPair.new
	end

	def create
		current_or_guest_user
		@url_pair = UrlPair.new(params[:url_pair])
		@url_pair.user_id = @id
		@url_pair.hit_count = 0
		if @url_pair.save
			redirect_to @url_pair, notice: "Url pair was successfully created" 
		else
			render action: "new"
		end
	end 
  
	def edit
		id
		@url_pair = UrlPair.find(params[:id])
	end

	def update
		@url_pair = UrlPair.find(params[:id])
		id
		@url_pair.user_id = @id
		if @url_pair.hit_count.nil? || @url_pair.hit_count <= 0
			@url_pair.hit_count = 0
		end
		if @url_pair.update_attributes(params[:url_pair])
			redirect_to(@url_pair, :notice => "Url pair was successfully updated")
		else
			render "edit"
		end
	end

	def destroy
		@url_pair = UrlPair.find(params[:id])
		@url_pair.destroy
		redirect_to url_pairs_url
	end
	
	def list_all
		@url_pairs = UrlPair.find(:all, :order => 'hit_count DESC')
		puts @url_pairs
		#@url_pairs.sort_by { |, hit_count| 
	end
  
	def graph
		current_or_guest_user
		#id
		@url_pairs = User.find_by_id(@id).url_pairs.all
		if @id != guest_user.id
			@urlp = @url_pairs.map do |u| u.hit_count end
			@urlg = User.find_by_id(guest_user.id).url_pairs.all.map do |ug| ug.hit_count end
		else
			@urlg = @url_pairs.map do |u| u.hit_count end
		end	
		@h = LazyHighCharts::HighChart.new('graph') do |f|
			f.options[:chart][:defaultSeriesType] = "column"
			f.options[:title][:text] = "Url Pair Hit Counts"
			f.options[:yAxis][:alternateGridColor] = '#FDFFD5'
			@urlc = @url_pairs.map do |u| u.short_url end
			puts @urlg
			f.xAxis(:categories=>@urlc)
			f.series(:name=>'Public', :data=>@urlg )
			f.series(:name=>'Private', :data=>@urlp )
		end
	end
end
