class ManifestosController < ApplicationController
    before_action :authenticate_user!, only: [:show, :update, :destroy, :create, :index]
    before_action :set_manifesto, only: [:show, :update, :destroy, :non_admin_show]
  
  
    # Admin views ----------------------------------------------------------
  
    # GET /manifestos
    def index
      @manifestos = Manifesto.all
      #@manifes
  
      render json: @manifestos, :status => :ok
    end
  
    # GET /manifestos/1
    def show
      render json: {
        id: @manifesto.id,
        pdf: url_for(@manifesto.pdf),
        created_at: @manifesto.created_at,
        updated_at: @manifesto.updated_at,
        active: @manifesto.active
      }, :status => :ok
    end
  
    # POST /manifestos
    def create
      @manifesto = Manifesto.new(manifesto_params)
  
      if @manifesto.save
        render json: @manifesto, status: :created, location: @manifesto
      else
        render json: @manifesto.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /manifestos/1
    def update
      if @manifesto.update(manifesto_params_active)
        render json: @manifesto, :status => :ok
      else
        render json: @manifesto.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /manifestos/1
    def destroy
      @manifesto.destroy
      render :status => :ok
    end
  
    # End of Admin views --------------------------------------------------------
  
    # Non-admin views ------------------------------------------
  
    def non_admin_index
      manifestos = Manifesto.select(:id, :name, :active)
      render json: manifestos, :status => :ok
    end
  
    def non_admin_show
      render json: {
        id: @manifesto.id,
        name: @manifesto.name,
        pdf: url_for(@manifesto.pdf),
        active: @manifesto.active
      }, :status => :ok
    end
  
    # End of Non-admin views -----------------------------------
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_manifesto
        begin
          @manifesto = Manifesto.find(params[:id])
        rescue
          render :status => :not_found
        end
        #@manifesto = Manifesto.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def manifesto_params
        params.permit(:name, :pdf)
      end
  
      # to update active
      def manifesto_params_active
        params.permit(:name, :pdf, :active)
      end
  end
  