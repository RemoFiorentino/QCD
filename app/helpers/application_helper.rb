module ApplicationHelper
    def nivelsatis(qcdid)
        n1 = 0
        n2 = 0
        n3 = 0
        n4 = 0
        n5 = 0
        @answergroup = Answergroup.where(qcd_id: qcdid)
        @answers = Answer.where(answergroup_id: @answergroup.ids, order: "2")
        @answers.each do |ans|
            if ans.answer == "1"
               n1 = n1 + 1
            end
            if ans.answer == "2"
               n2 = n2 + 1
            end
            if ans.answer == "3"
               n3 = n3 + 1
            end
            if ans.answer == "4"
               n4 = n4 + 1
            end
            if ans.answer == "5"
               n5 = n5 + 1
            end
        end
        n1 = n1*100/(@answers.length.nonzero? || 1)
        n2 = n2*100/(@answers.length.nonzero? || 1)
        n3 = n3*100/(@answers.length.nonzero? || 1)
        n4 = n4*100/(@answers.length.nonzero? || 1)
        n5 = n5*100/(@answers.length.nonzero? || 1)
        data = {labels: ["N1 Muy Bajo", "N2 Bajo", "N3 Medio", "N4 Alto", "N5 Muy Alto"],  datasets: [{label: "Nivel de satisfacción con la experiencia de aprendizaje en la asignatura",backgroundColor: [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)'
            ],
            borderColor: [
                'rgba(255,99,132,1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)'
            ],borderWidth: 1,data: [n1,n2,n3,n4,n5]}]}
        return data.to_json
    end
    def opisatis1(qcdid)
        @answergroup = Answergroup.where(qcd_id: qcdid)
        @answers1 = Answer.where(answergroup_id: @answergroup.ids, order: "1")
        return @answers1
    end
    def opisatis2(qcdid)
        @answergroup = Answergroup.where(qcd_id: qcdid)
        @answers2 = Answer.where(answergroup_id: @answergroup.ids, order: "2").order("answer ASC")
        return @answers2
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
    def bootstrap_class_for flash_type
        {success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info"}[flash_type.to_sym] || flash_type.to_s
    end
end
