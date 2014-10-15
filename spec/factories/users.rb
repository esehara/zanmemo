# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user, aliases: [:owner] do
    provider 'twitter'
    sequence(:uid) { |i| 'uid#{i}' }
    sequence(:nickname) { |i| 'nickname#{i}' }
  end
end
