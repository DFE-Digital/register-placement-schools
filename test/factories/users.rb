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
FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    email { "#{first_name}.#{last_name}+test@education.gov.uk" }

    trait :discarded do
      discarded_at { Time.zone.now }
    end

    trait :math_magician do
      id { "00000000-0000-0000-0000-000000000001" }
      first_name { "Mathilda" }
      last_name { "Mathmagician" }
    end
  end
end
