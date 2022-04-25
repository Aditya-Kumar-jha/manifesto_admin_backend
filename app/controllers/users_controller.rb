class UsersController < ApplicationController
    before_action :authenticate_user!, except: [:create, :login, :index]

    def index
        render json: {
            user: current_user
        }, :status => :ok
    end

    def update
        if current_user.update(password_params)
            render json: {
                message: :Password_updated
            }, :status => :201
        else
            render json: {
                message: 'Password does not match or Validation error'
            }, :status => :bad_request
        end
    end

    def new
        user = User.new
    end

    def create      # POST - for sign-up
        user = User.new(user_params)
        if user.save
            render json: {
                message: :Registration_successfull
            }, :status => :201
        else
            #render 'new'
            render json: {
                message: user.errors.full_messages
            }, :status => :unprocessable_entity
        end
    end

    def login       
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            auth_token = JWT.encode({user_id: user.id, exp: 24.hours.from_now.to_i}, Rails.application.secrets.secret_key_base, 'HS256')
            decoded_token = JWT.decode(auth_token, Rails.application.secrets.secret_key_base).first     # for testing purpose only
            render json: {
                message: 'logged-in successfully',
                auth_token: auth_token
                #decoded_token: decoded_token['user_id'],        # working
            }, :status => :accepted
        else
            render json: {
                errors: 'Invalid email/password'
            }, :status => :not_found
        end
    end


    protected


    private

    def user_params
        params.permit(:email, :password, :password_confirmation)
    end

    def password_params
        params.permit(:password, :password_confirmation)
    end

   
end