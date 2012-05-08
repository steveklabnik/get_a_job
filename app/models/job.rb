class Job < ActiveRecord::Base
  attr_accessible :status

  include Rails.application.routes.url_helpers

  def links
    list = []
    list << {:href => "self", :rel => job_path(self)} if persisted?
    list << {:href => jobs_path, :rel => "index"}
    list
  end

  # Queue stuff!
  def run
    sleep 10
    self.status = "finished"
    save!
  end
end
