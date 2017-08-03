# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user1 = User.create(email: 'admin@admin.com', password: 'password')
acc1 = Account.create(iban: Forgery('credit_card').number, balance: 1000)
acc1.roles.create(user: user1, role: 'owner')
user2 = User.create(email: 'me@example.com', password: 'secret')
Invite.create!(user_from_id: user1.id,
               user_to_id: user2.id,
               account_id: acc1.id)

%w[owner co-user].each do |el|
  Role.create(name: el)
end

