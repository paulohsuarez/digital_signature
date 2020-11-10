class RequestMailer < ApplicationMailer
    def request_email
        @user = params[:user]
        @request = params[:request]
        mail(to: @user.email, subject: 'Signature Request')
      end
end
