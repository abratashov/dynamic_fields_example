# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Destroy all
User.destroy_all
Tenant.destroy_all

# Seed data
tenant = Tenant.create(name: 'Tenant 1')

struct = tenant.dynamic_structs.create(
  name: "user_info",
  struct: {
    name: 'string',
    phone: 'integer',
    gender: { single_field: ['male', 'female', 'no_info'] },
    languages: { multiple_fields: ['uk', 'ru', 'en'] }
  }
)

user = User.create(tenant: tenant)

record = user.dynamic_records.create(
  dynamic_struct: struct,
  data: {
    name: 'Jack',
    phone: 123456789,
    gender: 'male1',
    languages: ['uk', 'en']
  }
)
