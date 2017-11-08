
class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def stripe_connect
    auth_params = request.env['omniauth.auth']

    puts! params, 'params'
    puts! auth_params, 'auth_params'

    p = Profile.where( :stripe_account_id => auth_params['uid'] ).first
    p ||= Profile.where( :email => params['state'] ).first
    if !p
      p = Profile.new( :stripe_account_id => auth_params['uid'], :email => params['state'] )
      flag = p.save
    end
    p.email             ||= params['state']
    p.stripe_account_id ||= auth_params['uid']
    if flag
      render :json => { :status => :ok }
    else
      render :json => { :status => :not_ok }
    end
  end

end

=begin
provider: stripe_connect
uid: acct_1AFZN3Dpn3WurCcc
info: !ruby/hash:OmniAuth::AuthHash::InfoHash
  scope: read_only
  livemode: false
  stripe_publishable_key: pk_test_dMliztLE3D9ajn4DnTfY34zW
credentials: !ruby/hash:OmniAuth::AuthHash
  token: sk_test_zoAc5xwOu4JtPcMyJmNfH9Lf
  expires: false
extra: !ruby/hash:OmniAuth::AuthHash
  raw_info: !ruby/hash:OmniAuth::AuthHash
    livemode: false
    token_type: bearer
    stripe_publishable_key: pk_test_dMliztLE3D9ajn4DnTfY34zW
    stripe_user_id: acct_1AFZN3Dpn3WurCcc
    scope: read_only
=end
