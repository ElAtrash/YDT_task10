class Team < ApplicationRecord
  has_many :users, dependent: :destroy
  validates :name, presence: true, uniqueness: true
  validates :region, presence: true
  
  scope :filter_by_name, -> (name) { where("name like ?", "#{name}%")}
  scope :filter_by_region, -> (name) { where("region like ?", "#{name}%")}

  # p @teams = Team.filter_by_region('Maryland').filter_by_name('Montana')
  # http://localhost:3000/api/v1/teams?name=Montana&region=Maryland
end
