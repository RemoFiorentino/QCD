class AnswergroupsController < ApplicationController
  before_action :set_answergroup, only: [:show, :edit, :update, :destroy]

  # GET /answergroups
  # GET /answergroups.json
  def index
    @answergroups = Answergroup.all
  end

  # GET /answergroups/1
  # GET /answergroups/1.json
  def show
  end

  # GET /answergroups/new
  def new
    @qcd = Qcd.find(params[:qcd_id])
    @answergroup = @qcd.answergroups.build
    @answer = @answergroup.answers.build
  end
  
  def grupal
    @qcd = Qcd.find(params[:qcd_id])
    @answergroup = @qcd.answergroups.build
    @answer = @answergroup.answers.build
  end


  # GET /answergroups/1/edit
  def edit
  end

  # POST /answergroups
  # POST /answergroups.json
  def create
    asignatura = Asignatura.find(params[:asignatura_id])
    @answergroup = Answergroup.new(answergroup_params)

    respond_to do |format|
      if @answergroup.save
        format.html { redirect_to asignatura_path(asignatura), notice: 'Answergroup was successfully created.' }
        format.json { render :show, status: :created, location: @answergroup }
      else
        format.html { render :new }
        format.json { render json: @answergroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /answergroups/1
  # PATCH/PUT /answergroups/1.json
  def update
    respond_to do |format|
      if @answergroup.update(answergroup_params)
        format.html { redirect_to @answergroup, notice: 'Answergroup was successfully updated.' }
        format.json { render :show, status: :ok, location: @answergroup }
      else
        format.html { render :edit }
        format.json { render json: @answergroup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answergroups/1
  # DELETE /answergroups/1.json
  def destroy
    @answergroup.destroy
    respond_to do |format|
      format.html { redirect_to answergroups_url, notice: 'Answergroup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answergroup
      @answergroup = Answergroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answergroup_params
      params.require(:answergroup).permit(:qcd_id, :answers_attributes => [:answergroup_id, :qcd_id, :order, :answer])
    end
end
