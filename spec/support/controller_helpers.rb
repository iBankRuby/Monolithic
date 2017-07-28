require 'devise'

# The ControllerHelpers module implemented for stub devise authentication
# For more information: https://github.com/plataformatec/devise/wiki/How-To:-Stub-authentication-in-controller-specs
module ControllerHelpers
  def sign_in(user = double('user'))
    if user.nil?
      allow_receive_authenticate
      allow_receive_current_user
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow_receive_current_user(user)
    end
  end

  def allow_receive_authenticate
    allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, scope: :user)
  end

  def allow_receive_current_user(user = nil)
    allow(controller).to receive(:current_user).and_return(user)
  end
end
