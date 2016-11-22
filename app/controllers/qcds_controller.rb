class QcdsController < ApplicationController
  before_action :set_qcd, only: [:show, :edit, :update, :destroy]

  # GET /qcds
  # GET /qcds.json
  def index
    @qcds = Qcd.all
  end

  # GET /qcds/1
  # GET /qcds/1.json
  def show
    @autoeficacia = autoeficacia(@qcd.id)
    @engament = engament(@qcd.id)
    @estadoAcad = estadoAcad(@qcd.id)
    @resultados = resultados(@qcd.id)
  end

  # GET /qcds/new
  def new
    asignatura = Asignatura.find(params[:asignatura_id])
    @qcd = asignatura.qcds.build
  end

  # GET /qcds/1/edit
  def edit
  end

  # POST /qcds
  # POST /qcds.json
  def create
    asignatura = Asignatura.find(params[:asignatura_id])
    @qcd = asignatura.qcds.create(qcd_params)
    @qcd.estados = 0
    respond_to do |format|
      if @qcd.save
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
    asignatura = Asignatura.find(params[:asignatura_id])
    @qcd = asignatura.qcds.find(params[:id])
    respond_to do |format|
      if @qcd.update(qcd_params)
        format.html { redirect_to asignatura_path(asignatura), notice: 'QCD Fue exitosamente actualizado.' }
        format.json { render :show, status: :ok, location: @qcd }
      else
        format.html { render :edit }
        format.json { render json: @qcd.errors, status: :unprocessable_entity }
      end
    end
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
      params.permit(:asignatura_id, :salon, :fecha, :grupo)
    end
    def autoeficacia(qcdid)
        answer = ["","",""]
        n1 = 0
        n2 = 0
        n3 = 0
        n4 = 0
        n5 = 0
        n6 = 0
        n7 = 0
        n8 = 0
        n9 = 0
        @answergroups = Answergroup.where(qcd_id: qcdid)
        @answergroups.each do |ag|
            answer15 = Answer.find_by_answergroup_id_and_order(ag.id,"15")
            answer16 = Answer.find_by_answergroup_id_and_order(ag.id,"16")
            answer17 = Answer.find_by_answergroup_id_and_order(ag.id,"17")
            answer18 = Answer.find_by_answergroup_id_and_order(ag.id,"18")
            answer21 = Answer.find_by_answergroup_id_and_order(ag.id,"21")
            answer22 = Answer.find_by_answergroup_id_and_order(ag.id,"22")
            answer24 = Answer.find_by_answergroup_id_and_order(ag.id,"24")
            if answer15 != nil && answer16 != nil && answer17 != nil && answer18 != nil && answer21 != nil && answer22 != nil && answer24 != nil
                t1 = ((answer15.answer.to_i + answer16.answer.to_i + answer17.answer.to_i)/3)
                t2 = ((answer18.answer.to_i + answer21.answer.to_i + answer22.answer.to_i + answer24.answer.to_i)/4)
                t3 = ((answer15.answer.to_i + answer16.answer.to_i + answer17.answer.to_i + answer18.answer.to_i + answer21.answer.to_i + answer22.answer.to_i + answer24.answer.to_i)/7)
                t1 = t1*100/4
                if t1 < 51
                    n1 = n1 + 1
                else 
                    if t1 < 71
                        n2 = n2 + 1
                    else
                        n3 = n3 + 1
                    end
                end
                t2= t2*100/4
                if t2 < 51
                    n4 = n4 + 1
                else 
                    if t2 < 71
                        n5 = n5 + 1
                    else
                        n6 = n6 + 1
                    end
                end
                t3 = t3*100/4
                if t3 < 51
                    n7 = n7 + 1
                else 
                    if t3 < 71
                        n8 = n8 + 1
                    else
                        n9 = n9 + 1
                    end
                end
            end
        end
        t1 = n1 + n2 + n3
        t2 = n4 + n5 + n6
        t3 = n7 + n8 + n9
        n1 = n1*100/(t1.nonzero? || 1)
        n2 = n2*100/(t1.nonzero? || 1)
        n3 = n3*100/(t1.nonzero? || 1)
        n4 = n4*100/(t2.nonzero? || 1)
        n5 = n5*100/(t2.nonzero? || 1)
        n6 = n6*100/(t2.nonzero? || 1)
        n7 = n7*100/(t3.nonzero? || 1)
        n8 = n8*100/(t3.nonzero? || 1)
        n9 = n9*100/(t3.nonzero? || 1)
        data = {labels: ["Baja", "Media", "Alta"],
        datasets: [
        {
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)'
            ],
            borderWidth: 1,
            data: [n1,n2,n3],
        }
        ]
        };
        answer[0] = data
        data = {labels: ["Baja", "Media", "Alta"],
        datasets: [
        {
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)'
            ],
            borderWidth: 1,
            data: [n4,n5,n6],
        }
        ]
        };
        answer[1] = data;
        data = {labels: ["Baja", "Media", "Alta"],
        datasets: [
        {
            backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)'
            ],
            borderWidth: 1,
            data: [n7,n8,n9],
        }
        ]
        };
        answer[2] = data;
        return answer
    end
    def engament(qcdid)
      answer = ["","","",""]
      n1 = 0
      n2 = 0
      n3 = 0
      n4 = 0
      n5 = 0
      n6 = 0
      n7 = 0
      n8 = 0
      n9 = 0
      n10 = 0
      n11 = 0
      n12 = 0
      @answergroups = Answergroup.where(qcd_id: qcdid)
      @answergroups.each do |ag|
        answer25 = Answer.find_by_answergroup_id_and_order(ag.id,"25")
        answer26 = Answer.find_by_answergroup_id_and_order(ag.id,"26")
        answer27 = Answer.find_by_answergroup_id_and_order(ag.id,"27")
        answer28 = Answer.find_by_answergroup_id_and_order(ag.id,"28")
        answer29 = Answer.find_by_answergroup_id_and_order(ag.id,"29")
        answer30 = Answer.find_by_answergroup_id_and_order(ag.id,"30")
        if answer25 != nil && answer26 != nil && answer27 != nil && answer28 != nil && answer29 != nil && answer30 != nil
            inclusion = ((answer28.answer.to_i + answer30.answer.to_i)/2)
            desafio = ((answer25.answer.to_i + answer27.answer.to_i)/2)
            apoyo = ((answer26.answer.to_i + answer29.answer.to_i)/2)
            inclusion = inclusion*100/4
            desafio = desafio*100/4
            apoyo = apoyo*100/4
            engatotal = (inclusion + desafio + apoyo)/3
            if inclusion < 51
                n1 = n1 + 1
            else 
                if inclusion < 71
                    n2 = n2 + 1
                else
                    n3 = n3 + 1
                end
            end
            if desafio < 51
                n4 = n4 + 1
            else 
                if desafio < 71
                    n5 = n5 + 1
                else
                    n6 = n6 + 1
                end
            end
            if apoyo < 51
                n7 = n7 + 1
            else 
                if apoyo < 71
                    n8 = n8 + 1
                else
                    n9 = n9 + 1
                end
            end
            if engatotal < 51
                n10 = n10 + 1
            else 
                if engatotal < 71
                    n11 = n11 + 1
                else
                    n12 = n12 + 1
                end
            end
        end
      end
      inclusion = n1 + n2 + n3
      desafio = n4 + n5 + n6
      apoyo = n7 + n8 + n9
      engatotal = n10 + n11 + n12
      n1 = n1*100/(inclusion.nonzero? || 1)
      n2 = n2*100/(inclusion.nonzero? || 1)
      n3 = n3*100/(inclusion.nonzero? || 1)
      n4 = n4*100/(desafio.nonzero? || 1)
      n5 = n5*100/(desafio.nonzero? || 1)
      n6 = n6*100/(desafio.nonzero? || 1)
      n7 = n7*100/(apoyo.nonzero? || 1)
      n8 = n8*100/(apoyo.nonzero? || 1)
      n9 = n9*100/(apoyo.nonzero? || 1)
      n10 = n10*100/(engatotal.nonzero? || 1)
      n11 = n11*100/(engatotal.nonzero? || 1)
      n12 = n12*100/(engatotal.nonzero? || 1)
      data = {labels: ["Bajo", "Moderado", "Alto"],
      datasets: [
      {
          backgroundColor: [
              'rgba(255, 99, 132, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(255, 206, 86, 0.2)'
          ],
          borderColor: [
              'rgba(255,99,132,1)',
              'rgba(54, 162, 235, 1)',
              'rgba(255, 206, 86, 1)',
              'rgba(75, 192, 192, 1)'
          ],
          borderWidth: 1,
          data: [n1,n2,n3],
      }
      ]
      };
      answer[0] = data
      data = {labels: ["Bajo", "Moderado", "Alto"],
      datasets: [
      {
          backgroundColor: [
              'rgba(255, 99, 132, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(255, 206, 86, 0.2)'
          ],
          borderColor: [
              'rgba(255,99,132,1)',
              'rgba(54, 162, 235, 1)',
              'rgba(255, 206, 86, 1)',
              'rgba(75, 192, 192, 1)'
          ],
          borderWidth: 1,
          data: [n4,n5,n6],
      }
      ]
      };
      answer[1] = data;
      data = {labels: ["Bajo", "Moderado", "Alto"],
      datasets: [
      {
          backgroundColor: [
              'rgba(255, 99, 132, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(255, 206, 86, 0.2)'
          ],
          borderColor: [
              'rgba(255,99,132,1)',
              'rgba(54, 162, 235, 1)',
              'rgba(255, 206, 86, 1)',
              'rgba(75, 192, 192, 1)'
          ],
          borderWidth: 1,
          data: [n7,n8,n9],
      }
      ]
      };
      answer[2] = data;
      data = {labels: ["Bajo", "Moderado", "Alto"],
      datasets: [
      {
          backgroundColor: [
              'rgba(255, 99, 132, 0.2)',
              'rgba(54, 162, 235, 0.2)',
              'rgba(255, 206, 86, 0.2)'
          ],
          borderColor: [
              'rgba(255,99,132,1)',
              'rgba(54, 162, 235, 1)',
              'rgba(255, 206, 86, 1)',
              'rgba(75, 192, 192, 1)'
          ],
          borderWidth: 1,
          data: [n10,n11,n12],
      }
      ]
      };
      answer[3] = data;
      return answer
    end
    def estadoAcad(qcdid)
      n1 = 0
      n2 = 0
      n3 = 0
      n4 = 0
      n5 = 0
      n6 = 0
      n7 = 0
      n8 = 0
      @answergroups = Answergroup.where(qcd_id: qcdid)
      @answergroups.each do |ag|
        answer13 = Answer.find_by_answergroup_id_and_order(ag.id,"13")
        answer14 = Answer.find_by_answergroup_id_and_order(ag.id,"14")
        if answer13 != nil && answer14 != nil
            case answer13.answer
            when "Entre 2,95 y 3,24"
              case answer14.answer
              when "Si"
                n1 = n1 + 1
              when "No"
                n5 = n5 + 1
              end
            when "Entre 3,25 y 3,94"
              case answer14.answer
              when "Si"
                n2 = n2 + 1
              when "No"
                n6 = n6 + 1
              end
            when "Entre 3,95 y 5,00"
              case answer14.answer
              when "Si"
                n3 = n3 + 1
              when "No"
                n7 = n7 + 1
              end
            when "Soy de primer semestre"
              case answer14.answer
              when "Si"
                n4 = n4 + 1
              when "No"
                n8 = n8 + 1
              end
            end
        end
      end
      total = n1 + n2 + n3 + n4 + n5 + n6 + n7 + n8
      n1 = n1 * 100 / (total.nonzero? || 1)
      n2 = n2 * 100 / (total.nonzero? || 1)
      n3 = n3 * 100 / (total.nonzero? || 1)
      n4 = n4 * 100 / (total.nonzero? || 1)
      n5 = n5 * 100 / (total.nonzero? || 1)
      n6 = n6 * 100 / (total.nonzero? || 1)
      n7 = n7 * 100 / (total.nonzero? || 1)
      n8 = n8 * 100 / (total.nonzero? || 1)
      data = {labels: ["Entre 2,95 y 3,24", "Entre 3,25 y 3,94", "Entre 3,95 y 5,00", "Soy de primer semestre"],
      datasets: [
      {
          label:"Becario",
          data: [n1,n2,n3,n4],
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255,99,132,1)',
          borderWidth: 1,
      },{
          label:"No Becario",
          backgroundColor: 'rgba(54, 162, 235, 0.2)',
          borderColor: 'rgba(54, 162, 235, 1)',
          borderWidth: 1,
          data: [n5,n6,n7,n8]
      }
      ]
      };
      return data
    end
    def resultados(qcdid)
      require 'matrix'
      matrix = [[0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0], [0, 0, 0]]
      count = 0
      @answergroups = Answergroup.where(qcd_id: qcdid)
      @answergroups.each do |ag|
        answer3 = Answer.find_by_answergroup_id_and_order(ag.id,"3")
        answer4 = Answer.find_by_answergroup_id_and_order(ag.id,"4")
        answer5 = Answer.find_by_answergroup_id_and_order(ag.id,"5")
        answer6 = Answer.find_by_answergroup_id_and_order(ag.id,"6")
        answer7 = Answer.find_by_answergroup_id_and_order(ag.id,"7")
        answer8 = Answer.find_by_answergroup_id_and_order(ag.id,"8")
        answer9 = Answer.find_by_answergroup_id_and_order(ag.id,"9")
        answer10 = Answer.find_by_answergroup_id_and_order(ag.id,"10")
        answer11 = Answer.find_by_answergroup_id_and_order(ag.id,"11")
        answer12 = Answer.find_by_answergroup_id_and_order(ag.id,"12")
        if answer3 != nil
          case answer3.answer.to_i
          when 1
            matrix[0][0] = matrix[0][0] + 1
          when 2
            matrix[0][1] = matrix[0][1] + 1
          when 3
            matrix[0][2] = matrix[0][2] + 1
          end
          count = count + 1
        end 
        if answer4 != nil
          case answer4.answer.to_i
          when 1
            matrix[1][0] = matrix[1][0] + 1
          when 2
            matrix[1][1] = matrix[1][1] + 1
          when 3
            matrix[1][2] = matrix[1][2] + 1
          end
        end
        if answer5 != nil
          case answer5.answer.to_i
          when 1
            matrix[2][0] = matrix[2][0] + 1
          when 2
            matrix[2][1] = matrix[2][1] + 1
          when 3
            matrix[2][2] = matrix[2][2] + 1
          end
        end
        if answer6 != nil
          case answer6.answer.to_i
          when 1
            matrix[3][0] = matrix[3][0] + 1
          when 2
            matrix[3][1] = matrix[3][1] + 1
          when 3
            matrix[3][2] = matrix[3][2] + 1
          end
        end
        if answer7 != nil
          case answer7.answer.to_i
          when 1
            matrix[4][0] = matrix[4][0] + 1
          when 2
            matrix[4][1] = matrix[4][1] + 1
          when 3
            matrix[4][2] = matrix[4][2] + 1
          end
        end
        if answer8 != nil
          case answer8.answer.to_i
          when 1
            matrix[5][0] = matrix[5][0] + 1
          when 2
            matrix[5][1] = matrix[5][1] + 1
          when 3
            matrix[5][2] = matrix[5][2] + 1
          end
        end
        if answer9 != nil
          case answer9.answer.to_i
          when 1
            matrix[6][0] = matrix[6][0] + 1
          when 2
            matrix[6][1] = matrix[6][1] + 1
          when 3
            matrix[6][2] = matrix[6][2] + 1
          end
        end
        if answer10 != nil
          case answer10.answer.to_i
          when 1
            matrix[7][0] = matrix[7][0] + 1
          when 2
            matrix[7][1] = matrix[7][1] + 1
          when 3
            matrix[7][2] = matrix[7][2] + 1
          end
        end
        if answer11 != nil
          case answer11.answer.to_i
          when 1
            matrix[8][0] = matrix[8][0] + 1
          when 2
            matrix[8][1] = matrix[8][1] + 1
          when 3
            matrix[8][2] = matrix[8][2] + 1
          end
        end
        if answer12 != nil
          case answer12.answer.to_i
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
          matrix[i][j] = matrix[i][j]*100/count
        end
      end
      data = {labels: ["Res1", "Res2", "Res3", "Res4", "Res5", "Res6", "Res7", "Res8", "Res9", "Res10"],
      datasets: [
      {
          label:"Se ha logrado completamente",
          data: [matrix[0][2],matrix[1][2],matrix[2][2],matrix[3][2],matrix[4][2],matrix[5][2],matrix[6][2],matrix[7][2],matrix[8][2],matrix[9][2]],
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255,99,132,1)',
          borderWidth: 1,
      },{
          label:"Se ha logrado parcialmente",
          backgroundColor: 'rgba(54, 162, 235, 0.2)',
          borderColor: 'rgba(54, 162, 235, 1)',
          borderWidth: 1,
          data: [matrix[0][1],matrix[1][1],matrix[2][1],matrix[3][1],matrix[4][1],matrix[5][1],matrix[6][1],matrix[7][1],matrix[8][1],matrix[9][1]]
      },{
          label:"No se ha logrado",
          backgroundColor: 'rgba(255, 206, 86, 0.2)',
          borderColor: 'rgba(255, 206, 86, 1)',
          borderWidth: 1,
          data: [matrix[0][0],matrix[1][0],matrix[2][0],matrix[3][0],matrix[4][0],matrix[5][0],matrix[6][0],matrix[7][0],matrix[8][0],matrix[9][0]]
      }
      ]
      };
      return data
    end
end
