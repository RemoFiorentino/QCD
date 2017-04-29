class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers/new
  def new
    @ans = Answergroup.find(params[:answergroup_id])
    @answer = @ans.answers.build
  end

  # POST /answers
  # POST /answers.json
  def create
    qcd = Qcd.find(params[:qcd_id])
    params[:answer].each do |answer_para|
      @answer = qcd.answers.create(answer_para)
    end
    respond_to do |format|
      if @answer.save
        format.html { redirect_to asignatura_qcd_answer_path(@answer), notice: 'Answer was successfully created.' }
        format.json { render :show, status: :created, location: @answer }
      else
        format.html { render :new }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      params.require(:answer).permit(:qcd_id, :order, :answer)
    end
end
