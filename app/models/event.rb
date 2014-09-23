class Event < ActiveRecord::Base
  belongs_to :gallery
  
  def self.upcoming
    Event.all.where("begins_at > ?", Time.now)
  end

  def self.past
    Event.all.where("begins_at < ?", Time.now)
  end
end
