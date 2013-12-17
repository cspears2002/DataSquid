# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :node, :class => 'Nodes' do
    name "MyString"
    group 1
    link nil
  end
end
