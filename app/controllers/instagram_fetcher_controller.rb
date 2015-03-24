class InstagramFetcherController < ApplicationController
  def index
    @instagram = InstagramFetcher.new
    if params[:code].present?
      @access_token = @instagram.authenticate(params[:code])
      session[:access_token] = @access_token
      @my_feed = @instagram.get_my_feed(@access_token)
      if params[:user_id].present?
        @user_feed = @instagram.get_user_feed(params[:user_id], @access_token)
      end
    end
  end



end
