class Mailer < ApplicationMailer
    def profe_email(user,qcd)
        @user = user
        mail(to: @user.email, subject: 'Cambio en el QCD')
    end
    def cedu_email() 
        mail(to: "remojose29@gmail.com", subject: 'Nuevo QCD')
    end
end
