class ContentsController < ApplicationController
    before_action :authenticate_user!, only: [:show, :update, :destroy, :create, :index]
    before_action :set_content, only: [:show, :update, :destroy, :non_admin_show]
  
    # Admin views ---------------------------------------
  
    # GET /contents
    def index
      @contents = Content.all
      #@contents = Content.select(:heading, :desc, :small_img)
  
      render json: @contents, :status => :ok
    end
  
    # GET /contents/1
    def show
      #render json: @content
      render json: {
        id: @content.id,
        heading: @content.heading,
        description: @content.desc,
        small_img: url_for(@content.small_img),
        big_img: url_for(@content.big_img),
        created_at: @content.created_at,
        updated_at: @content.updated_at,
        active: @content.active
      }, :status => :ok
      # render :img => url_for(@content.small_img), :status => :accepted
    end
  
    # POST /contents
    def create
      @content = Content.new(content_params)
  
      if @content.save
        #render json: @content, status: :created, location: @content
        render status: :created
      else
        render json: @content.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /contents/1
    def update
      if @content.update(content_params_active)
        render json: @content, :status => :ok
      else
        render json: @content.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /contents/1
  
    def destroy
      @content.destroy
      render :status => :ok
    end
  
    # End of Admin views ---------------------------------------
  
    # Non-admin views ------------------------------------------
  
    def non_admin_index
      contents = Content.select(:id, :heading, :desc, :active)
      render json: contents, :status => :ok
    end
  
    def non_admin_show
      render json: {
        id: @content.id,
        heading: @content.heading,
        description: @content.desc,
        small_img: url_for(@content.small_img),
        big_img: url_for(@content.big_img)
      }, :status => :ok
    end
  
    # End of Non-admin views ------------------------------------------
  
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_content
        begin
          @content = Content.find(params[:id])
        rescue
          render :status => :not_found
        end
        # print @content, "content"
      end
  
      # Only allow a list of trusted parameters through.
      def content_params
        params.permit(:heading, :desc, :small_img, :big_img)
      end
  
      # to update active
      def content_params_active
        params.permit(:heading, :desc, :small_img, :big_img, :active)
      end
  end
  