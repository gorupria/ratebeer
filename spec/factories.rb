FactoryBot.define do
  factory :user do
    username { "Pekka" }
    password { "Foobar1" }
    password_confirmation { "Foobar1" }
  end

  factory :brewery do
    name { "anonymous" }
    year { 1900 }
  end

  factory :style do
    name { "Lager" }
    description { "This is the description for Lager" }
  end

  factory :beer do
    name { "anonymous" }
    style  
    brewery
  end

  factory :rating do
    beer
  end

end
