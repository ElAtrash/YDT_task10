class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
         
  belongs_to :team
  enum gender: { undisclosed: 'undisclosed', male: 'male', female: 'female', other: 'others' }
  validates :name, :phone, :gender, :email, presence: true

  scope :filter_by_team, -> (team_ids) { where(team_id: team_ids) }
  # http://localhost:3000/api/v1/users?team_id=1
end
