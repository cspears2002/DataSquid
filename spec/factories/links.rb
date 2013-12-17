# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link, :class => 'Links' do
    value 1
    checked false
  end
end
