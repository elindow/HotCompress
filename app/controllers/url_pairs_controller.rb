class UrlPairsController < ApplicationController
def id
	if @guest_user
		@id = guest_user.id
	else
		@id = current_user.id
	end
end

 def index
	@url_pairs = UrlPair.find(:all)
	current_or_guest_user
	id
	if guest_user
		puts "Logged in as guest"
		puts guest_user.email

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
	#@url_pair.user_id = @id
  end

  def create
	current_or_guest_user
	id
	@url_pair = UrlPair.new(params[:url_pair])
	@url_pair.user_id = @id
	if @url_pair.save
		redirect_to @url_pair, notice: "Url pair was successfully created" 
	else
		render action: "new"
	end
  end 
  
  def edit
	@url_pair = UrlPair.find(params[:id])
  end

  def update
	@url_pair = UrlPair.find(params[:id])
	if @url_pair.update_attributes(params[:url_pair])
		redirect_to(@url_pair, :notice => "Url pair was successfully updated")
	else
		render action "edit"
	end
  end

  def destroy
	@url_pair = UrlPair.find(params[:id])
	@url_pair.destroy
	redirect_to url_pairs_url
  end
end
