# == Schema Information
#
# Table name: users
#
#  id                :uuid             not null, primary key
#  dfe_sign_in_uid   :string
#  discarded_at      :datetime
#  email             :string           not null
#  first_name        :string           not null
#  last_name         :string           not null
#  last_signed_in_at :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_discarded_at  (discarded_at)
#  index_users_on_email         (email) UNIQUE
#
class User < ApplicationRecord
  self.implicit_order_column = :created_at
  include Discard::Model

  audited

  before_validation :sanitise_email

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  validate do |record|
    DfEEmailFormatValidator.new(record).validate if email.present?
  end

  scope :order_by_first_then_last_name, -> { order(:first_name, :last_name) }

  def name
    first_name_to_use = first_name_was || first_name
    last_name_to_use = last_name_was || last_name
    "#{first_name_to_use} #{last_name_to_use}"
  end

private

  def sanitise_email
    self.email = email.gsub(/\s+/, "").downcase unless email.nil?
  end
end
