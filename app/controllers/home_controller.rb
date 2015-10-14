class HomeController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index

   if user_signed_in?
    @exam_count = Check.where(:user_email => current_user.email).count  
   end
   @all_professor = Professor.all
   @all_test = Test.all
   @all_user = User.all

  end
  
  def show
        
    
        @pro = Professor.where(:name => params[:professor]).take
   
      
      
     
      unless @pro.nil?

        @checks = Check.where(:professor_id => @pro.id ) #해당교수님 정보 불러오기
        
        abc = @checks.count #해당교수님 정보 개수
        
        #과목별평균
        @a_average = (@checks.sum(:a)/abc).round(1) #a평균
        @b_average = (@checks.sum(:b)/abc).round(1) #b평균
        @c_average = (@checks.sum(:c)/abc).round(1) #c평균
        @d_average = (@checks.sum(:d)/abc).round(1) #d평균
        @e_average = (@checks.sum(:e)/abc).round(1) #e평균
        @f_average = (@checks.sum(:f)/abc).round(1) #f평균
        
        #점수 빈도
        @a_count_a = Check.where(:a => 4.5, :professor_id => @pro.id).count #a점수가 4.5인 개수
        @a_count_b = Check.where(:a => 3.5, :professor_id => @pro.id).count #a점수가 3.5인 개수
        @a_count_c = Check.where(:a => 2.5, :professor_id => @pro.id).count #a점수가 2.5인 개수
        
        @b_count_a = Check.where(:b => 4.5, :professor_id => @pro.id).count #b점수가 4.5인 개수
        @b_count_b = Check.where(:b => 3.5, :professor_id => @pro.id).count #b점수가 3.5인 개수
        @b_count_c = Check.where(:b => 2.5, :professor_id => @pro.id).count #b점수가 2.5인 개수
        
        @c_count_a = Check.where(:c => 4.5, :professor_id => @pro.id).count #c점수가 4.5인 개수
        @c_count_b = Check.where(:c => 3.5, :professor_id => @pro.id).count #c점수가 3.5인 개수
        @c_count_c = Check.where(:c => 2.5, :professor_id => @pro.id).count #c점수가 2.5인 개수
        
        @d_count_a = Check.where(:d => 4.5, :professor_id => @pro.id).count #d점수가 4.5인 개수
        @d_count_b = Check.where(:d => 3.5, :professor_id => @pro.id).count #d점수가 3.5인 개수
        @d_count_c = Check.where(:d => 2.5, :professor_id => @pro.id).count #d점수가 2.5인 개수
        
        @e_count_a = Check.where(:e => 4.5, :professor_id => @pro.id).count #e점수가 4.5인 개수
        @e_count_b = Check.where(:e => 3.5, :professor_id => @pro.id).count #e점수가 3.5인 개수
        @e_count_c = Check.where(:e => 2.5, :professor_id => @pro.id).count #e점수가 2.5인 개수
        
        @f_count_a = Check.where(:f => 4.5, :professor_id => @pro.id).count #f점수가 4.5인 개수
        @f_count_b = Check.where(:f => 3.5, :professor_id => @pro.id).count #f점수가 3.5인 개수
        @f_count_c = Check.where(:f => 2.5, :professor_id => @pro.id).count #f점수가 2.5인 개수
    
        #평균비교
         @user = Check.where(:user_email => current_user.email, :professor_id => @pro.id ).take #user가져오기
         unless @user.nil?
         user_average = (@user.a + @user.b + @user.c + @user.d + @user.e + @user.f)/6
         @user_average_final = user_average.round(1) #내평균
         
         all_average = (@a_average + @b_average + @c_average + @d_average + @e_average + @f_average)/6
         @all_average_final = all_average.round(1)  #전체평균
         
         men = Check.where(:professor_id => @pro.id, :sex => "men")
         men_middle = men.sum(:a) + men.sum(:b) + men.sum(:c) + men.sum(:d) + men.sum(:e) + men.sum(:f)
         men_final_sub = men_middle / (men.count * 6).round(1) 
         @men_final = men_final_sub.round(1) #남성평균
         
         women = Check.where(:professor_id => @pro.id, :sex => "women")
         women_middle = women.sum(:a) + women.sum(:b) + women.sum(:c) + women.sum(:d) + women.sum(:e) + women.sum(:f)
         women_final_sub = women_middle/ (women.count * 6).round(1) 
         @women_final = women_final_sub.round(1) #여성평균
         
         end
      else
        redirect_to '/'
      end
   
  end
  
  def save
    checks = Check.new
    checks.user_email = current_user.email
    checks.sex = current_user.gender
    checks.professor_id = params[:professor_id]
    checks.a = params[:options_1].to_f
    checks.b = params[:options_2].to_f
    checks.c = params[:options_3].to_f
    checks.d = params[:options_4].to_f
    checks.e = params[:options_5].to_f
    checks.f = params[:options_6].to_f
    checks.course = params[:course]
    checks.comment = params[:comment]
    checks.save
    redirect_to :back
  end
  
  def search  #족보 검색 컨트롤러

    @tests = Test.where(:course => params[:course])
  end
  
  def upload #족보 올리기
    tests = Test.new
    tests.course = params[:course]
    tests.professor = params[:professor]
    tests.year = params[:year]
    tests.middle = params[:middle]
    tests.fileing = params[:fileing]
    tests.save
    redirect_to :back
  end
  
  def show_exam #모든 족보 보여주기
    @tests = Test.all  
  end
  
  
  def write_save
    uri = URI("https://nokogiri-bsm7878-2.c9.io/")
    html_doc = Nokogiri::HTML(Net::HTTP.get(uri))
    i = 0
    j = 0
      while i < 744
        professors = Professor.new
        
        img_sub = html_doc.css("div.thumbnail // img")[i].attr('src')
        professors.img = img_sub
        professors.name = html_doc.css("div.caption // p")[j].inner_text
        professors.space = html_doc.css("div.caption // p")[j+1].inner_text
        professors.phone = html_doc.css("div.caption // p")[j+2].inner_text
        professors.email  =html_doc.css("div.caption // p")[j+3].inner_text
        professors.save
        
        i = i + 1
        j = j + 4
        
      end
  end
  

  
  def email_send
    
    send_user = params[:send_user]
    send_title = params[:send_title]
    send_content = params[:send_content]
    Mailpost.welcome_email(send_user, send_title, send_content).deliver_now
    redirect_to '/'
    
  end
  
  
  def delete
    user_delete = User.find(params[:id])
    user_delete.destroy
    redirect_to '/'
  end
end
