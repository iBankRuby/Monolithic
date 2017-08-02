User.new(email: 'me@example.com', password: 'secret').save
Invite.create!(user_from_id: 2,
               user_to_id: 1,
               account_id: 1)
