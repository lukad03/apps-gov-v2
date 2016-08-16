FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Subcategory-#{n}" }

    trait :with_products do
      after(:create) do |category|
        products = create_list(:product, 3)
        subcategory = create(:subcategory, category: category)
        products.each do |product|
          create(
            :product_subcategory,
            subcategory: subcategory,
            product: product
          )
        end
      end
    end
  end
end
