class JobsController < ApplicationController
  before_filter :set_profile

  def new
    render :json => Job.new
  end

  def create
    job = Job.new(params[:job])
    job.save

    # quite possibly could be in the model in after_create
    Rails.queue.push job

    redirect_to job
  end

  def update
    @job = Job.find(params[:job][:id])

    @job.update_attributes(params[:job])
    @job.save

    redirect_to @job
  end

  def show
    render :json => Job.find(params[:id])
  end

  private

  def set_profile
    response.headers["Link"] = %Q{<#{profile_url}>; rel="profile"}
  end
end
