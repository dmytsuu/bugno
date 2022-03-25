# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable,
         :validatable,
         :recoverable,
         :rememberable,
         :registerable

  validates :email, uniqueness: true

  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users

  before_create :assign_extras

  def assign_extras
    self.nickname = email
    self.name = email
    self.uid = SecureRandom.base64
    self.provider = 'email'
  end
end
