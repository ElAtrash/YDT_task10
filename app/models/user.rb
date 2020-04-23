class User < ApplicationRecord
  belongs_to :team
  enum gender: { undisclosed: 'undisclosed', male: 'male', female: 'female', other: 'others' }
  validates :name, presence: true
  validates :phone, presence: true
  validates :gender, presence: true

  scope :filter_by_team, -> (team_ids) { where(team_id: team_ids) }
  # http://localhost:3000/api/v1/users?team_id=1
end
