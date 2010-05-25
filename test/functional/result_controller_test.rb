require File.dirname(__FILE__) + '/../test_helper'

class ResultControllerTest < ActionController::TestCase
   
  def test_export_data
    login_as :tino 
    get :export_data, :survey_id => surveys(:survey_one).id

    assert_response :success
    assert_kind_of Proc, @response.body

    require 'stringio'
    output = StringIO.new
    assert_nothing_raised { @response.body.call(@response, output) }
    assert_equal csv_data, output.string
  end
  
  def test_show
    assert true
  end

  private 
    def csv_data
      #"first,last,id,email\r\nQuentin,Smith,1,<a href=\"mailto:quentin@example.com\">quentin@example.com</a>\r\nAaron,Jones,2,<a href=\"mailto:aaron@example.com\">aaron@example.com</a>"
      #"id,answer,question_id,option_id,response_id\r\n953125641,MyString,953125641,,953125641\r\n996332877,MyString,953125641,,953125641\r\n1052946184,MyString,996332877,,953125641\r\n"
      #"id,answer,question_id,option_id,response_id\r\n953125641,MyString,645912946,,953125641\r\n996332877,MyString,645912946,,953125641\r\n1052946184,MyString,996332877,,953125641\r\n"
      #"id,answer,question_id,option_id,response_id\r\n953125641,MyString,645912946,,953125641\r\n996332877,MyString,645912946,,953125641\r\n1052946184,MyString,591412650,,953125641\r\n"
      #"id,answer,question_id,option_id,response_id\r\n8501642,1,905967551,245809336,953125641\r\n68441142,radio one,311329782,23757888,953125641\r\n96140419,select one,299496843,327326541,953125641\r\n121899743,2008-07-06,540503127,,953125641\r\n385796010,Neutral,636677126,,953125641\r\n691350735,Afghanistan,804363243,,953125641\r\n842780933,textarea answer,339857043,,953125641\r\n953125641,MyString,645912946,,953125641\r\n996332877,MyString,645912946,,953125641\r\n1003911066,1,905967551,202602100,953125641\r\n1052946184,MyString,591412650,,953125641\r\n"
      #"id,answer,question_id,option_id,response_id\r\n8501642,1,905967551,245809336,953125641\r\n68441142,radio one,311329782,23757888,953125641\r\n96140419,select one,299496843,327326541,953125641\r\n121899743,2008-07-06,540503127,,953125641\r\n127787143,100,246962045,,953125641\r\n385796010,Neutral,636677126,,953125641\r\n691350735,Afghanistan,804363243,,953125641\r\n842780933,textarea answer,339857043,,953125641\r\n953125641,MyString,645912946,,953125641\r\n996332877,MyString,645912946,,953125641\r\n1003911066,1,905967551,202602100,953125641\r\n1052946184,MyString,591412650,,953125641\r\n"
      "id,answer,question.type,question.title,question_id,option.label,option_id,response_id\r\n8501642,1,checkbox,checkbox,905967551,MyString,245809336,953125641\r\n68441142,radio one,radio,radio,311329782,radio one,23757888,953125641\r\n96140419,select one,select,select,299496843,select one,327326541,953125641\r\n121899743,2008-07-06,date,date,540503127,\"\",,953125641\r\n127787143,100,number,number,246962045,\"\",,953125641\r\n302767486,Neutral,likert,likert,636677126,likert two,864685080,953125641\r\n691350735,Afghanistan,country,country,804363243,\"\",,953125641\r\n715089010,Neutral,likert,likert,636677126,likert one,821477844,953125641\r\n842780933,textarea answer,textarea,textarea,339857043,\"\",,953125641\r\n953125641,MyString,text,MyString,645912946,\"\",,953125641\r\n996332877,MyString,text,MyString,645912946,\"\",,953125641\r\n1003911066,1,checkbox,checkbox,905967551,MyString,202602100,953125641\r\n1052946184,MyString,text,MyString,591412650,\"\",,953125641\r\n"
    end
end
