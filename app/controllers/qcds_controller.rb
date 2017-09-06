class QcdsController < ApplicationController
  before_action :set_qcd, only: [:show, :edit, :update, :destroy]

  # GET /qcds
  # GET /qcds.json
  def index
    # @qcds = Qcd.all
  end

  # GET /qcds/1
  # GET /qcds/1.json
  def show
    @qcd = Qcd.find(params[:id])
    @answers = getanswerInd
    @answersGrupal = getanswerGru
    @satisfaccion = getcomments(@answers,"1","2")
    @pertinencia = getcomments(@answers,"26","25")
    @nivelperti = nivel(@answers, "25")
    @nivelsatis = nivel(@answers,"2")
    @autoeficacia = autoeficacia(@answers)
    @engament = engament(@answers)
    @estadoAcad = estadoAcad(@answers)
    @resultados = resultados(@answers)
    @fortalezas = fortalezas(@answersGrupal)
    respond_to do |format|
      format.html
      format.pdf do
        pdf = WickedPdf.new.pdf_from_string(
        render_to_string('qcds/show.pdf.haml',
          layout: "pdf_layout.html.haml",
          image_quality:100,
          lowquality: false,
          :javascript_delay => 5000),
        )
        send_data pdf, filename: "prueba.pdf",
              type: 'application/pdf',
              disposition: 'inline'
      end
      format.csv do
        
      end
    end
  end

  # GET /qcds/new
  def new
    # asignatura = Asignatura.find(params[:asignatura_id])
    # @newQcd = Qcd.new
  end

  # GET /qcds/1/edit
  def edit
  end

  # POST /qcds
  # POST /qcds.json
  def create
    asignatura = Asignatura.find(params[:asignatura_id])
    @qcd = asignatura.qcds.new(qcd_params)
    @qcd.estados = 0
    @qcd.fecha =  DateTime::strptime("#{params[:fecha]} -0500", "%m/%d/%Y %I:%M %p %z")
    #logger.debug("QCD estado #{@qcd.estados}")
    respond_to do |format|
      if @qcd.save
        Mailer.cedu_email(@qcd).deliver
        format.html { redirect_to asignatura_path(asignatura), notice: 'QCD Fue exitosamente creado' }
        format.json { render :show, status: :created, location: @qcd }
      else
        format.html { render :new }
        format.json { render json: @qcd.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /qcds/1
  # PATCH/PUT /qcds/1.json
  def update
    # asignatura = Asignatura.find(params[:asignatura_id])
    # @qcd = asignatura.qcds.find(params[:id])
    # respond_to do |format|
    #   if @qcd.update(qcd_params)
    #     Mailer.profe_email(qcd.asignatura.user.email).deliver
    #     format.html { redirect_to asignatura_path(asignatura), notice: 'QCD Fue exitosamente actualizado.' }
    #     format.json { render :show, status: :ok, location: @qcd }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @qcd.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /qcds/1
  # DELETE /qcds/1.json
  def destroy
    @qcd.destroy
    respond_to do |format|
      format.html { redirect_to qcds_url, notice: 'Qcd was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qcd
      @qcd = Qcd.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def qcd_params
      params.permit(:asignatura_id, :salon, :fecha, :grupo, :estados)
    end
    def getcomments(answergroup, a, b)
      temp = answergroup.map{ |n| [n["#{a}"], n["#{b}"]]}.reject { |c| c[1].nil?} 
      temp = temp.group_by{|n| n[1]}.sort
      return temp
    end
    def nivel(answergroup, a)
        n = Array.new(5, 0)
        nl = 0.0
        answergroup.each do |ans|
            if ans["#{a}"] == "1"
               n[0] = n[0] + 1
               nl = nl + 1
            end
            if ans["#{a}"] == "2"
               n[1] = n[1] + 1
               nl = nl + 1
            end
            if ans["#{a}"] == "3"
               n[2] = n[2] + 1
               nl = nl + 1
            end
            if ans["#{a}"] == "4"
               n[3] = n[3] + 1
               nl = nl + 1
            end
            if ans["#{a}"] == "5"
               n[4] = n[4] + 1
               nl = nl + 1
            end
        end
        n[0] = (n[0]*100/(nl.nonzero? || 1)).round
        n[1] = (n[1]*100/(nl.nonzero? || 1)).round
        n[2] = (n[2]*100/(nl.nonzero? || 1)).round
        n[3] = (n[3]*100/(nl.nonzero? || 1)).round
        n[4] = (n[4]*100/(nl.nonzero? || 1)).round
        return n
    end
    def autoeficacia(answergroup)
      answer = Array.new(3, "")
      n = Array.new(9, 0.0)
      temp = Array.new(3, 0.0)
      answergroup.each do |ans|
        temp[0] = (((ans["15"].to_f || 0) + (ans["16"].to_f || 0))/2)
        temp[1] = (((ans["17"].to_f || 0) + (ans["18"].to_f || 0))/2)
        temp[2] = (((ans["15"].to_f || 0) + (ans["16"].to_f || 0) + (ans["17"].to_f || 0) + (ans["18"].to_f || 0) )/4)
        temp[0] = temp[0]*100/4
        if temp[0] < 51
          n[0] = n[0] + 1
        else
          if temp[0] < 71
            n[1] = n[1] + 1
          else
            n[2] = n[2] + 1
          end
        end
        temp[1] = temp[1]*100/4  
        if temp[1] < 51
          n[3] = n[3] + 1
        else
          if temp[1] < 71
            n[4] = n[4] + 1
          else
            n[5] = n[5] + 1
          end
        end
        temp[2] = temp[2]*100/4
        if temp[2] < 51
          n[6] = n[6] + 1
        else
          if temp[2] < 71
            n[7] = n[7] + 1
          else
            n[8] = n[8] + 1
          end
        end
      end 
      temp[0] = n[0] + n[1] + n[2]
      temp[1] = n[3] + n[4] + n[5]
      temp[2] = n[6] + n[7] + n[8]
      n[0] = (n[0]*100/(temp[0].nonzero? || 1)).round
      n[1] = (n[1]*100/(temp[0].nonzero? || 1)).round
      n[2] = (n[2]*100/(temp[0].nonzero? || 1)).round
      n[3] = (n[3]*100/(temp[1].nonzero? || 1)).round
      n[4] = (n[4]*100/(temp[1].nonzero? || 1)).round
      n[5] = (n[5]*100/(temp[1].nonzero? || 1)).round
      n[6] = (n[6]*100/(temp[2].nonzero? || 1)).round
      n[7] = (n[7]*100/(temp[2].nonzero? || 1)).round
      n[8] = (n[8]*100/(temp[2].nonzero? || 1)).round
      return n
    end
    def engament(answergroup)
      n = Array.new(12, 0.0)
      answergroup.each do |ans|
        if ans["19"] != nil && ans["20"] != nil && ans["21"] != nil && ans["22"] != nil && ans["23"] != nil && ans["24"] != nil
        inclusion = ((ans["22"].to_f + ans["24"].to_f)/2)
        desafio = ((ans["19"].to_f + ans["21"].to_f)/2)
        apoyo = ((ans["20"].to_f + ans["23"].to_f)/2)
        inclusion = inclusion*100/4
        desafio = desafio*100/4
        apoyo = apoyo*100/4
        engatotal = (inclusion + desafio + apoyo)/3
        if inclusion < 51
            n[0] = n[0] + 1
        else 
            if inclusion < 71
                n[1] = n[1] + 1
            else
                n[2] = n[2] + 1
            end
        end
        if desafio < 51
            n[3] = n[3] + 1
        else 
            if desafio < 71
                n[4] = n[4] + 1
            else
                n[5] = n[5] + 1
            end
        end
        if apoyo < 51
            n[6] = n[6] + 1
        else 
            if apoyo < 71
                n[7] = n[7] + 1
            else
                n[8] = n[8] + 1
            end
        end
        if engatotal < 51
            n[9] = n[9] + 1
        else 
            if engatotal < 71
                n[10] = n[10] + 1
            else
                n[11] = n[11] + 1
            end
        end
        end
      end
      inclusion = n[0] + n[1] + n[2]
      desafio = n[3] + n[4] + n[5]
      apoyo = n[6] + n[7] + n[8]
      engatotal = n[9] + n[10] + n[11]
      n[0] = (n[0]*100/(inclusion.nonzero? || 1)).round
      n[1] = (n[1]*100/(inclusion.nonzero? || 1)).round
      n[2] = (n[2]*100/(inclusion.nonzero? || 1)).round
      n[3] = (n[3]*100/(desafio.nonzero? || 1)).round
      n[4] = (n[4]*100/(desafio.nonzero? || 1)).round
      n[5] = (n[5]*100/(desafio.nonzero? || 1)).round
      n[6] = (n[6]*100/(apoyo.nonzero? || 1)).round
      n[7] = (n[7]*100/(apoyo.nonzero? || 1)).round
      n[8] = (n[8]*100/(apoyo.nonzero? || 1)).round
      n[9] = (n[9]*100/(engatotal.nonzero? || 1)).round
      n[10] = (n[10]*100/(engatotal.nonzero? || 1)).round
      n[11] = (n[11]*100/(engatotal.nonzero? || 1)).round
      return n
    end
    def estadoAcad(answergroup)
      n = Array.new(8,0.0)
      answergroup.each do |ag|
        if ag["13"] != nil && ag["14"] != nil
            case ag["13"]   
            when "Entre 2,95 y 3,24"
              case ag["14"].downcase 
              when "si"
                n[0] = n[0] + 1
              when "no"
                n[4] = n[4] + 1
              end
            when "Entre 3,25 y 3,94"
              case ag["14"].downcase 
              when "si"
                n[1] = n[1] + 1
              when "no"
                n[5] = n[5] + 1
              end
            when "Entre 3,95 y 5,00"
              case ag["14"].downcase 
              when "si"
                n[2] = n[2] + 1
              when "no"
                n[6] = n[6] + 1
              end
            when "Soy de primer semestre"
              case ag["14"].downcase 
              when "si"
                n[3] = n[3] + 1
              when "no"
                n[7] = n[7] + 1
              end
            end
        end
      end
      total = n[0] + n[1] + n[2] + n[3] + n[4] + n[5] + n[6] + n[7]
      n[0] = (n[0] * 100 / (total.nonzero? || 1)).round
      n[1] = (n[1] * 100 / (total.nonzero? || 1)).round
      n[2] = (n[2] * 100 / (total.nonzero? || 1)).round
      n[3] = (n[3] * 100 / (total.nonzero? || 1)).round
      n[4] = (n[4] * 100 / (total.nonzero? || 1)).round
      n[5] = (n[5] * 100 / (total.nonzero? || 1)).round
      n[6] = (n[6] * 100 / (total.nonzero? || 1)).round
      n[7] = (n[7] * 100 / (total.nonzero? || 1)).round
      return n
    end
    def resultados(answergroup)
      require 'matrix'
      matrix = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]]
      count = 0
      answergroup.each do |ag|
        if ag["3"] != nil
          case ag["3"].to_i
          when 1
            matrix[0][0] = matrix[0][0] + 1
          when 2
            matrix[0][1] = matrix[0][1] + 1
          when 3
            matrix[0][2] = matrix[0][2] + 1
          end
          count = count + 1
        end 
        if ag["4"] != nil
          case ag["4"].to_i
          when 1
            matrix[1][0] = matrix[1][0] + 1
          when 2
            matrix[1][1] = matrix[1][1] + 1
          when 3
            matrix[1][2] = matrix[1][2] + 1
          end
        end
        if ag["5"] != nil
          case ag["5"].to_i
          when 1
            matrix[2][0] = matrix[2][0] + 1
          when 2
            matrix[2][1] = matrix[2][1] + 1
          when 3
            matrix[2][2] = matrix[2][2] + 1
          end
        end
        if ag["6"] != nil
          case ag["6"].to_i
          when 1
            matrix[3][0] = matrix[3][0] + 1
          when 2
            matrix[3][1] = matrix[3][1] + 1
          when 3
            matrix[3][2] = matrix[3][2] + 1
          end
        end
        if ag["7"] != nil
          case ag["7"].to_i
          when 1
            matrix[4][0] = matrix[4][0] + 1
          when 2
            matrix[4][1] = matrix[4][1] + 1
          when 3
            matrix[4][2] = matrix[4][2] + 1
          end
        end
        if ag["8"] != nil
          case ag["8"].to_i
          when 1
            matrix[5][0] = matrix[5][0] + 1
          when 2
            matrix[5][1] = matrix[5][1] + 1
          when 3
            matrix[5][2] = matrix[5][2] + 1
          end
        end
        if ag["9"] != nil
          case ag["9"].to_i
          when 1
            matrix[6][0] = matrix[6][0] + 1
          when 2
            matrix[6][1] = matrix[6][1] + 1
          when 3
            matrix[6][2] = matrix[6][2] + 1
          end
        end
        if ag["10"] != nil
          case ag["10"].to_i
          when 1
            matrix[7][0] = matrix[7][0] + 1
          when 2
            matrix[7][1] = matrix[7][1] + 1
          when 3
            matrix[7][2] = matrix[7][2] + 1
          end
        end
        if ag["11"] != nil
          case ag["11"].to_i
          when 1
            matrix[8][0] = matrix[8][0] + 1
          when 2
            matrix[8][1] = matrix[8][1] + 1
          when 3
            matrix[8][2] = matrix[8][2] + 1
          end
        end
        if ag["12"] != nil
          case ag["12"].to_i
          when 1
            matrix[9][0] = matrix[9][0] + 1
          when 2
            matrix[9][1] = matrix[9][1] + 1
          when 3
            matrix[9][2] = matrix[9][2] + 1
          end
        end
      end
      for i in 0..9
        for j in 0..2
          matrix[i][j] = matrix[i][j]*100/(count.nonzero? || 1)
        end
      end
      return matrix
    end
    def fortalezas(answergroup)
      n = Array.new(18, 0.0)
      nl = 0.0
      nl2 = 0.0
      answergroup.each do |ans|
        if ans["33"] == "1"
           n[0] = n[0] + 1
           nl = nl + 1
        else
          if ans["33"] == "2"
             n[1] = n[1] + 1
             nl = nl + 1
          else
            if ans["33"] == "3"
               n[2] = n[2] + 1
               nl = nl + 1
            else
              if ans["33"] == "4"
                 n[3] = n[3] + 1
                 nl = nl + 1
              else
                if ans["33"] == "5"
                   n[4] = n[4] + 1
                   nl = nl + 1
                else
                  if ans["33"] == "6"
                     n[5] = n[5] + 1
                     nl = nl + 1
                  else
                    if ans["33"] == "7"
                       n[6] = n[6] + 1
                       nl = nl + 1
                    else
                      if ans["33"] == "8"
                         n[7] = n[7] + 1
                         nl = nl + 1
                      else
                        if ans["33"] == "9"
                           n[8] = n[8] + 1
                           nl = nl + 1
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
        if ans["34"] == "1"
           n[9] = n[9] + 1
           nl2 = nl2 + 1
        else
          if ans["34"] == "2"
             n[10] = n[10] + 1
             nl2 = nl2 + 1
          else
            if ans["34"] == "3"
               n[11] = n[11] + 1
               nl2 = nl2 + 1
            else
              if ans["34"] == "4"
                 n[12] = n[12] + 1
                 nl2 = nl2 + 1
              else
                if ans["34"] == "5"
                   n[13] = n[13] + 1
                   nl2 = nl2 + 1
                else
                  if ans["34"] == "6"
                     n[14] = n[14] + 1
                     nl2 = nl2 + 1
                  else
                    if ans["34"] == "7"
                       n[15] = n[15] + 1
                       nl2 = nl2 + 1
                    else
                      if ans["34"] == "8"
                         n[16] = n[16] + 1
                         nl2 = nl2 + 1
                      else
                        if ans["34"] == "9"
                           n[17] = n[17] + 1
                           nl2 = nl2 + 1
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
      n[0] = (n[0]*100/(nl.nonzero? || 1)).round
      n[1] = (n[1]*100/(nl.nonzero? || 1)).round
      n[2] = (n[2]*100/(nl.nonzero? || 1)).round
      n[3] = (n[3]*100/(nl.nonzero? || 1)).round
      n[4] = (n[4]*100/(nl.nonzero? || 1)).round
      n[5] = (n[5]*100/(nl.nonzero? || 1)).round
      n[6] = (n[6]*100/(nl.nonzero? || 1)).round
      n[7] = (n[7]*100/(nl.nonzero? || 1)).round
      n[8] = (n[8]*100/(nl.nonzero? || 1)).round
      n[9] = (n[9]*100/(nl2.nonzero? || 1)).round
      n[10] = (n[10]*100/(nl2.nonzero? || 1)).round
      n[11] = (n[11]*100/(nl2.nonzero? || 1)).round
      n[12] = (n[12]*100/(nl2.nonzero? || 1)).round
      n[13] = (n[13]*100/(nl2.nonzero? || 1)).round
      n[14] = (n[14]*100/(nl2.nonzero? || 1)).round
      n[15] = (n[15]*100/(nl2.nonzero? || 1)).round
      n[16] = (n[16]*100/(nl2.nonzero? || 1)).round
      n[17] = (n[17]*100/(nl2.nonzero? || 1)).round
      return n
    end
    def getanswerInd()
      answergroup = Answergroup.where(qcd_id: @qcd.id, group: true)
      answers = []
      answergroup.each do |a|
        answers << (JSON.parse a.answer)
      end
      return answers
    end
    def getanswerGru()
      answergroup = Answergroup.where(qcd_id: @qcd.id, group: false)
      answers = []
      answergroup.each do |a|
        answers << (JSON.parse a.answer)
      end
      return answers
    end
  end