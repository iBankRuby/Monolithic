class InviteMailer < ApplicationMailer
  def invite(email)
    mail(to: email, subject: 'Invite')
  end

  def invite_for_existing_user(user)
    mail(to: user.email, subject: 'Invite')
  end
end
