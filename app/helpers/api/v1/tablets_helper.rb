module Api::V1::TabletsHelper

  def check_http_basic_auth
    authenticate_or_request_with_http_basic do |email, password|
      user = User.where(email: email).first
      return render :status => :unauthorized, :json => { notice: 'Unauthorized' } unless user && user.valid_password?(password)

      sign_in :user, user
    end
  end
end
