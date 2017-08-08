# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string
#  password_digest :string
#  email           :string
#  admin           :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord

  # associations


  before_save { |user| user.username = user.username.downcase }

  validates :username,
    presence: true,
    uniqueness: {case_sensitive:false},
    length: {minimum: 3, maximum: 25}

  # NOTE: removing this for now - users dont need to give me an email
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # validates :email,
  #   format: {with: VALID_EMAIL_REGEX},
  #   uniqueness: {case_sensitive: false}

  has_secure_password

end
