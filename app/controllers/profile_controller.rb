class ProfileController < ApplicationController
  def show
    render File.open("#{Rails.root}/public/profile.html")
  end
end
