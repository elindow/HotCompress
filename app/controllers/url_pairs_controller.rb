class UrlPairsController < ApplicationController

	def uid
		if @guest_user
			@uid = guest_user.id
		else
			if current_user.nil?
				@uid = User.find_by_email("guest@e.com")
			else 
				@uid = current_user.id
			end
		end
	end

	def index
		current_or_guest_user
		@url_pairs = User.find_by_id(@uid).url_pairs.all
		@url_pairs.sort_by! { |s| s[:short_url]}
		@host = request.host
		@port = request.port
		puts "domain: #{@host}:#{@port}"
		if @uid == guest_user.id
			puts "Logged in as guest"
		else
			puts "Logged in as #{current_user.email}"
		end
	end

	def show
		uid
		@url_pair = UrlPair.find(params[:id])
	end

	def new
		uid
		@rand = false
		@url_pair = UrlPair.new
		@url_pair.long_url = "http://"
		@url_pair.short_url = SecureRandom.urlsafe_base64(2)
		#@url_pair.short_url = 'y'
		#UrlPair.all do |u| puts "test #{u.include?(@url_pair.short_url)}" end
		#UrlPair.all do |u| puts "test" end
	end

	def create
		current_or_guest_user
		@url_pair = UrlPair.new(params[:url_pair])
		@url_pair.user_id = @uid
		@url_pair.hit_count = 0
		if @url_pair.save
			redirect_to @url_pair, notice: "Url pair was successfully created" 
		else
			render action: "new"
		end
	end 
  
	def edit
		uid
		@url_pair = UrlPair.find(params[:id])
	end

	def update
		@url_pair = UrlPair.find(params[:id])
		uid
		@url_pair.user_id = @uid
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
		current_or_guest_user
		puts @uid
		redirect_to url_pairs_url
	end
	
	def list_all
		current_or_guest_user
		@url_pairs = UrlPair.find(:all, :order => 'hit_count DESC')
		puts @url_pairs
		#@url_pairs.sort_by { |, hit_count| 
	end
  
	def graph
		current_or_guest_user
		#@url_pairs = User.find_by_id(@id).url_pairs.all
		@url_pairs = UrlPair.find(:all, :order => 'hit_count DESC')
		if @uid != guest_user.id
			@urlp = @url_pairs.map do |u| u.hit_count end
			#@urlg = User.find_by_id(guest_user.id).url_pairs.all.map do |ug| ug.hit_count end
		else
			@urlp = @url_pairs.map do |u| u.hit_count end
		end	
		@h = LazyHighCharts::HighChart.new('graph') do |f|
			f.options[:chart][:defaultSeriesType] = "bar"
			f.options[:title][:text] = "Url Pair Hit Counts"
			f.options[:yAxis][:alternateGridColor] = '#FDFFD5'
			#f.tooltip[:formatter][:function] = "Short Url is @{this.x}"
			@urlc = @url_pairs.map do |u| "#{u.long_url} : #{u.short_url}" end
			f.xAxis(:categories=>@urlc)
			f.series(:name=>'All Pairs', :data=>@urlp )
			#f.series(:name=>'Private', :data=>@urlp )
		end
	end
end
