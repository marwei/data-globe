FactoryGirl.define do
  factory :globe do
    sequence :name do |n|
      "Globe #{n}"
    end
    description "description"

    factory :globe_with_points do
      ignore do
        points_count 5
      end

      after(:create) do |globe, evaluator|
        create_list(:point, evaluator.points_count, globe: globe)
      end
    end
  end
end