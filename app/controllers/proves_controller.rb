class ProvesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profe, only: [:show, :edit, :update, :destroy]

  # GET /proves
  # GET /proves.json

  # GET /proves/1
  # GET /proves/1.json
  def show
  end

  # GET /proves/new
  def new
    @profe = Profe.new
  end

  # GET /proves/1/edit
  def edit
  end

  # POST /proves
  # POST /proves.json
  def create
    @profe = Profe.new(profe_params)

    respond_to do |format|
      if @profe.save
        format.html { redirect_to asignaturas_path, notice: 'Perfil creado exitosamente.' }
        format.json { render :show, status: :created, location: @profe }
      else
        format.html { render :new }
        format.json { render json: @profe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proves/1
  # PATCH/PUT /proves/1.json
  def update
    respond_to do |format|
      if @profe.update(profe_params)
        format.html { redirect_to @asignaturas, notice: 'Perfil actualizado exitosamente.' }
        format.json { render :show, status: :ok, location: @profe }
      else
        format.html { render :edit }
        format.json { render json: @profe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proves/1
  # DELETE /proves/1.json
  def destroy
    @profe.destroy
    respond_to do |format|
      format.html { redirect_to proves_url, notice: 'Profe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profe
      @profe = Profe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profe_params
      params.require(:profe).permit(:user_id, :ubicacion, :numero)
    end
end
