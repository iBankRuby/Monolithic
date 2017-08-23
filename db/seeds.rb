# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# user1 = User.create(email: 'admin@admin.com', password: 'password')
# user1.update_attributes(confirmed_at: Time.now)
# acc1 = Account.create(iban: Forgery('credit_card').number, balance: 1000)
%w[owner co-user read_only].each do |el|
  Role.create!(name: el)
end
