FactoryBot.define do
  factory(:tenant) do
    name { Faker::Name.name }

    trait :with_struct_user_info do
      after(:create) do |tenant|
        tenant.dynamic_structs.create(
          name: "user_info",
          struct: {
            name: 'string',
            phone: 'integer',
            gender: { single_field: ['male', 'female', 'no_info'] },
            languages: { multiple_fields: ['uk', 'ru', 'en'] }
          }
        )
      end
    end
  end
end
