class UrlPairsController < ApplicationController
  def index
	@url_pairs = UrlPair.find(:all)
  end

  def show
	@url_pair = UrlPair.find(params[:id])
  end

  def new
	@url_pair = UrlPair.new
  end

  def create
	@url_pair = UrlPair.new(params[:url_pair])
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
		@url_pair.destroy
		redirect_to url_pairs_url
  end
end