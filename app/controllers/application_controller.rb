class ApplicationController < ActionController::API

    attr_reader :current_user

    def authenticate_user!
        unless user_id_in_token?
            render json: {
                errors: :Not_Authorized
            }, :status => :unauthorized
        return
        end
        @current_user = User.find(auth_token['user_id'])
        puts current_user.id, "current_user"
    rescue JWT::VerificationError, JWT::DecodeError
        render json: {
            errors: :Not_Authorized
        }, :status => :unauthorized
    end


    private

    def http_token
        @http_token ||= if request.headers['Authorization'].present?
            request.headers['Authorization'].split(' ').last
        end
        
    end

    def auth_token
        begin
            @auth_token ||= JWT.decode(http_token, Rails.application.secrets.secret_key_base).first
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        end
      end
    
    def user_id_in_token?
        http_token && auth_token && auth_token['user_id'].to_i
    end
end
