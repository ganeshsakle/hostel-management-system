# frozen_string_literal: true

module JsonWebTokenValidation
  private

  def validate_json_web_token
    token = request.headers[:token] || params[:token]
    if token.present?
      begin
        jwt_payload = JWT.decode(token.split.last, Rails.application.credentials.devise_jwt_secret_key!).first
        @user = User.find(jwt_payload['sub'])
      rescue JWT::ExpiredSignature
        return render json: { errors: [token: 'Token has Expired'] },status: :unauthorized
      end
    else
      return render json: { errors: [token: 'Invalid token'] }, status: :bad_request
    end
  end
end
