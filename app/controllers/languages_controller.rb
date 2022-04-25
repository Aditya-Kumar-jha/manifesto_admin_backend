class LanguagesController < ApplicationController
    before_action :authenticate_user!, only: [:show, :update, :destroy, :create, :index]
        
    # GET /languages
        def index
          @languages = Language.all
          
      
          render json: @languages, :status => :ok
        end
      
        def show
          render json: {
            id: @language.id,
            lang: @language.lang
          }, :status => :ok
          
        end
      
        # POST /languages
        def create
          @language = Language.new(language_params)
      
          if @language.save
            render status: :created
          else
            render json: @language.errors, status: :unprocessable_entity
          end
        end
      
        
        # DELETE /languages/1
      
        def destroy
          @language.destroy
          render :status => :ok
        end
    
        private
          
          # Only allow a list of trusted parameters through.
          def language_params
            params.permit(:lang)
          end
      
      
          
end
