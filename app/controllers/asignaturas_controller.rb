class AsignaturasController < ApplicationController
  before_action :authenticate_user!
  before_action :set_asignatura, only: [:show, :edit, :update, :destroy]

  # GET /asignaturas
  # GET /asignaturas.json
  def index
    #@asignaturas = Asignatura.all
    @asignaturas = Asignatura.where(profe_id: current_user.profe.id).order("semestre DESC")
  end

  # GET /asignaturas/1
  # GET /asignaturas/1.json
  def show
    @qcd = Qcd.where(asignatura_id: @asignatura.id)
  end

  # GET /asignaturas/new
  def new
    @asignatura = Asignatura.new
  end

  # GET /asignaturas/1/edit
  def edit
  end

  # POST /asignaturas
  # POST /asignaturas.json
  def create
    @asignatura = Asignatura.new(asignatura_params)

    respond_to do |format|
      if @asignatura.save
        format.html { redirect_to asignaturas_path, notice: 'Asignatura was successfully created.' }
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
        format.html { redirect_to asignaturas_path, notice: 'Asignatura was successfully updated.' }
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
  
  def qcdform
    @rapidfire_question_group = RapidfireQuestionGroup.new
    @rapidfire_question_group.name = @asignatura.nrc + @asignatura.semestre
    @rapidfire_question_group.asignatura = @asignatura
    if @rapidfire_question_group.save
      format.html { redirect_to asignaturas_path, notice: 'Asignatura was successfully created.' }
    else
      format.html { redirect_to asignaturas_path, notice: 'No se pudo' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_asignatura
      @asignatura = Asignatura.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def asignatura_params
      params.require(:asignatura).permit(:profe_id, :division, :dpto, :programa, :nombre, :nrc, :semestre, :creditos, :objetivo1, :objetivo2, :objetivo3, :objetivo4, :objetivo5, :objetivo6, :objetivo7, :objetivo8, :objetivo9, :objetivo10)
    end
end
