class AsignaturasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_asignatura, only: [:show, :edit, :update, :destroy]
  
  # GET /asignaturas
  # GET /asignaturas.json
  def index
    @asignaturas = Asignatura.where(user_id: current_user.id).order("semestre DESC")
  end

  # GET /asignaturas/1
  # GET /asignaturas/1.json
  def show
    control_access
    @qcd = Qcd.where(asignatura_id: @asignatura.id)
  end

  # GET /asignaturas/new
  def new
    @asignatura = Asignatura.new
    @date = listyear
  end
  
  def copy
    @origin = Asignatura.find(params[:id])
    @asignatura = Asignatura.new
    @asignatura.division = @origin.division
    @asignatura.dpto = @origin.dpto
    @asignatura.programa = @origin.programa
    @asignatura.nombre = @origin.nombre
    @asignatura.semestre = @origin.semestre
    @asignatura.creditos = @origin.creditos
    @asignatura.objetivo1 = @origin.objetivo1
    @asignatura.objetivo2 = @origin.objetivo2
    @asignatura.objetivo3 = @origin.objetivo3
    @asignatura.objetivo4 = @origin.objetivo4
    @asignatura.objetivo5 = @origin.objetivo5
    @asignatura.objetivo6 = @origin.objetivo6
    @asignatura.objetivo7 = @origin.objetivo7
    @asignatura.objetivo8 = @origin.objetivo8
    @asignatura.objetivo9 = @origin.objetivo9
    @asignatura.objetivo10 = @origin.objetivo10
    @asignatura.num_estud = @origin.num_estud
    @date = listyear
  end

  # GET /asignaturas/1/edit
  def edit
    @date = listyear
  end

  # POST /asignaturas
  # POST /asignaturas.json
  def create
    @asignatura = Asignatura.new(asignatura_params)

    respond_to do |format|
      if @asignatura.save
        format.html { redirect_to asignaturas_path, notice: 'Asignatura creada satisfactoriamente' }
        format.json { render :show, status: :created, location: @asignatura }
      else
        format.html { render :new }
        format.json { render json: @asignatura.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /asignaturas/1
  # PATCH/PUT /asignaturas/1.json
  def update
    respond_to do |format|
      if @asignatura.update(asignatura_params)
        format.html { redirect_to asignaturas_path, notice: 'Asignatura actualizada satisfactoriamente.' }
        format.json { render :show, status: :ok, location: @asignatura }
      else
        format.html { render :edit }
        format.json { render json: @asignatura.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asignaturas/1
  # DELETE /asignaturas/1.json
  def destroy
    @asignatura.destroy
    respond_to do |format|
      format.html { redirect_to asignaturas_url, notice: 'Asignatura was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asignatura
      @asignatura = Asignatura.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asignatura_params
      params.require(:asignatura).permit(:user_id, :division, :dpto, :programa, :nombre, :nrc, :semestre, :creditos, :num_estud, :objetivo1, :objetivo2, :objetivo3, :objetivo4, :objetivo5, :objetivo6, :objetivo7, :objetivo8, :objetivo9, :objetivo10)
    end
    
    def control_access
      if !current_user
        return false
      end
      if current_user.id != @asignatura.user_id
        redirect_to error_no_permiso_path
        return false
      end
    end
end
