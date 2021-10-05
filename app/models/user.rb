# frozen_string_literal: true

class User < ActiveRecord::Base
  # extend Devise::Models
  devise :database_authenticatable,
         :validatable,
         :recoverable

  validates :email, uniqueness: true

  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users
end
