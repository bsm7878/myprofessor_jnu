class Mailpost < ApplicationMailer
    
    def welcome_email(content_1, content_2, content_3)
        mail from: content_1,
               to: 'myprofessor_jnu@naver.com', 
          subject: content_2,
             body: content_3
    end
    
    def all_email(content_1, content_2, content_3)
        mail from: 'myprofessor_jnu@naver.com',
               to: content_1, 
          subject: content_2,
             body: content_3
    end
    
    
end
