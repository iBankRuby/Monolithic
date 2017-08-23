class InviteMailer < ApplicationMailer
  def invite(user, user_from)
    @user = user
    @user_from = user_from
    mail(to: user.email, subject: 'Invite')
  end

end
