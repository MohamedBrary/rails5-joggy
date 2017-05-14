class Run < ApplicationRecord
  belongs_to :user

  # -- Validations
    
  validates_presence_of   :date
  validates_presence_of   :duration
  validates_presence_of   :distance
  validates_presence_of   :avg_speed

  validate :duration_length
 
  def duration_length
    if duration > 1.day.seconds
      errors.add(:duration, "Can't be more than a day! Bolt!")
    end
  end

  # -- Callbacks

  before_validation :adjust_duration, :calculate_avg_speed

  def adjust_duration
    # convert minutes into seconds
    self.duration = duration.to_i * 60
  end

  def calculate_avg_speed
  	# duration in seconds, and distance in meters
  	# producing avg. speed in km/h
  	self.avg_speed = (distance.to_f / 1000) / (duration.to_f / 3600)
  end

  # -- Duration

  def duration_minutes
    duration.to_f / 60
  end

  # -- Fitering
  scope :between, -> (from, to) {where("date >= ? && date <= ?", from || Date.new, to || 10.years.from_now.to_date)}
  
  # -- Stats
  # TODO dry this up

  scope :by_user, -> (user_id) { where(user_id: user_id) }  
  scope :current_week, -> { where(date: Time.now.beginning_of_week..Time.now.end_of_week) }
  scope :prev_week, -> { where(date: 7.days.ago.beginning_of_week..7.days.ago.end_of_week) }
  scope :last_week_num, -> (week_num) { where(date: (week_num*7).days.ago.beginning_of_week..(week_num*7).days.ago.end_of_week) }

  # -- Stats::AvgSpeed

  def self.avg_speed(user_id=nil)
    scope = self
    scope = scope.by_user(user_id) if user_id.present?
    scope.average(:avg_speed)
  end

  def self.avg_speed_current_week(user_id=nil)
    scope = self.current_week
    scope = scope.by_user(user_id) if user_id.present?
    scope.average(:avg_speed)
      
  end

  def self.avg_speed_prev_week(user_id=nil)
    scope = self.prev_week
    scope = scope.by_user(user_id) if user_id.present?
    scope.average(:avg_speed)
  end

  # -- Stats::Duration

  def self.duration(user_id=nil)
    scope = self
    scope = scope.by_user(user_id) if user_id.present?
    scope.sum(:duration)
  end

  def self.duration_current_week(user_id=nil)
    scope = self.current_week
    scope = scope.by_user(user_id) if user_id.present?
    scope.sum(:duration)
      
  end

  def self.duration_prev_week(user_id=nil)
    scope = self.prev_week
    scope = scope.by_user(user_id) if user_id.present?
    scope.sum(:duration)
  end

  # -- Stats::Distance

  def self.distance(user_id=nil)
    scope = self
    scope = scope.by_user(user_id) if user_id.present?
    scope.sum(:distance)
  end

  def self.distance_current_week(user_id=nil)
    scope = self.current_week
    scope = scope.by_user(user_id) if user_id.present?
    scope.sum(:distance)
      
  end

  def self.distance_prev_week(user_id=nil)
    scope = self.prev_week
    scope = scope.by_user(user_id) if user_id.present?
    scope.sum(:distance)
  end

  # -- Stats::RunsCount

  def self.run_counts(user_id=nil)
    scope = self
    scope = scope.by_user(user_id) if user_id.present?
    scope.count
  end

  def self.run_counts_current_week(user_id=nil)
    scope = self.current_week
    scope = scope.by_user(user_id) if user_id.present?
    scope.count
  end

  def self.run_counts_prev_week(user_id=nil)
    scope = self.prev_week
    scope = scope.by_user(user_id) if user_id.present?
    scope.count
  end

  # -- Stats::Comparisons  

  def self.compare_weeks_avg_speed(user_id=nil)
    prev_week = avg_speed_prev_week(user_id).to_f
    current_week = avg_speed_current_week(user_id).to_f
    
    compare prev_week, current_week
  end

  def self.compare_weeks_duration(user_id=nil)
    prev_week = duration_prev_week(user_id).to_i
    current_week = duration_current_week(user_id).to_i
    
    compare prev_week, current_week
  end

  def self.compare_weeks_distance(user_id=nil)
    prev_week = distance_prev_week(user_id).to_i
    current_week = distance_current_week(user_id).to_i
    
    compare prev_week, current_week
  end

  def self.compare_weeks_run_counts(user_id=nil)
    prev_week = run_counts_prev_week(user_id).to_i
    current_week = run_counts_current_week(user_id).to_i
    
    compare prev_week, current_week
  end

  def self.compare prev_week, current_week
    # return 0 if current_week == 0 && prev_week == 0
    # prev_week > current_week ? -1*prev_week/current_week : current_week/prev_week
    current_week - prev_week
  end
end
