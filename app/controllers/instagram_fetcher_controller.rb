class InstagramFetcherController < ApplicationController
  def index
    @instagram = InstagramFetcher.new
    @photos = @instagram.instagram
  end

end
