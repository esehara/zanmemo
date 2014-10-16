# -*- coding: utf-8 -*-
# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :memo do
    association :user, :factory => :owner
    sequence(:content) { |i| "メモの内容#{i}" }
  end
end
