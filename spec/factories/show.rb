FactoryBot.define do
  factory :show do
    sequence(:title) { |n| "Show ##{n}" }
    sequence(:start_date) { |n| (2 * n).days.from_now }
    sequence(:end_date) { |n| (2 * n + 1).days.from_now }
  end
end
