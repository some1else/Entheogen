class Event < ActiveRecord::Base
  def self.upcoming
    Event.all.where("begins_at > ?", Time.now)
  end

  def self.past
    Event.all.where("begins_at > ?", Time.now)
  end
end
