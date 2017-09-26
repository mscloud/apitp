FactoryGirl.define do
  sequence :group_name do |n|
    "#{["TD","TP","CM"].sample} #{n}"
  end

  factory :group do
    year { SchoolDateHelper.school_year }
    name { generate(:group_name) }
    association :admin, factory: :admin_user
  end
end
