class Job < ActiveRecord::Base
  validates :number_one, :number_two, :numericality => { :only_integer => true }

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
    self.answer = number_one + number_two
    self.status = "finished"
    save!
  end
end
