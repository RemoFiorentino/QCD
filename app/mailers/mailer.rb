class Mailer < ApplicationMailer
    def profe_email(user,qcd)
        @user = user
        @qcd = qcd
        mail(to: @user.email, subject: 'Cambio en el QCD')
    end
    def cedu_email(qcd) 
        @qcd = qcd
        mail(to: "remojose29@gmail.com", subject: 'Nueva Solicitud QCD')
    end
end

# kricaurte@uninorte.edu.co, 