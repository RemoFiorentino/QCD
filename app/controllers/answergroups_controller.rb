class AnswergroupsController < ApplicationController
  before_action :set_answergroup, only: [:show, :edit, :update, :destroy]

  # GET /answergroups/new
  def new
    @qcd = Qcd.find(params[:qcd_id])
    if @qcd.estados != "Aprobado"
      redirect_to error_no_disponible_path
      return true
    end
    @answergroup = @qcd.answergroups.build
  end
  
  def grupal
    @qcd = Qcd.find(params[:qcd_id])
    if @qcd.estados != "Aprobado"
      redirect_to error_no_disponible_path
      return true
    end
    @answergroup = @qcd.answergroups.build
  end


  # POST /answergroups
  # POST /answergroups.json
  def create
    asignatura = Asignatura.find(params[:asignatura_id])
    @answergroup = Answergroup.new(answergroup_params)
    @answergroup.answer = params[:answers].to_json
    respond_to do |format|
      if @answergroup.save
        format.html { redirect_to :controller => 'estudiante', :action => 'index', nrc: asignatura.nrc, semestre: asignatura.semestre, notice: 'Actividad enviada con exito!' }
        format.json { render :show, status: :created, location: @answergroup }
      else
        format.html { render :new }
        format.json { render json: @answergroup.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answergroup
      @answergroup = Answergroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answergroup_params
      params.require(:answergroup).permit(:qcd_id, :answer, :group)
    end
end
