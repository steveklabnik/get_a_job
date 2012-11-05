class JobsController < ApplicationController
  before_filter :set_profile

  def new
    render :json => JobSerializer.new(Job.new, :scope => true)
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
    @job = Job.find(params[:id])

    render :json => JobSerializer.new(@job, :scope => true)
  end

  private

  def set_profile
    response.headers["Link"] = %Q{<#{profile_url}>; rel="profile"}
  end
end
