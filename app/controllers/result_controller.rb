require 'rubygems'
require 'RMagick'
require 'fastercsv'
require 'gruff'

class ResultController < ApplicationController
  before_filter :find_survey 
  
  def export_data
    # TODO scope answer to survey & expand export data with question data
    responses = @survey.export_answers #Answer.find(:all)
    stream_csv do |csv|
      csv << ["id","answer","question.type","question.title","question_id","option.label","option_id","response_id"]
      responses.each do |r|
        option_label = !r.option_id.blank? ? r.option.label : ''
        csv << [r.id,r.answer,r.question.type,r.question.title,r.question_id,option_label,r.option_id,r.response_id]
      end
    end
  end

  def show
  end

  private
  
  def find_survey
    @survey = Survey.find(params[:survey_id])
    @questionTypes = QuestionType.find(:all)
  end
  
  def stream_csv
     filename = params[:action] + ".csv"    

     #this is required if you want this to work with IE        
     if request.env['HTTP_USER_AGENT'] =~ /msie/i
       headers['Pragma'] = 'public'
       headers["Content-type"] = "text/plain" 
       headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
       headers['Content-Disposition'] = "attachment; filename=\"#{filename}\"" 
       headers['Expires'] = "0" 
     else
       headers["Content-Type"] ||= 'text/csv'
       headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" 
     end

    render :text => Proc.new { |response, output|
      csv = FasterCSV.new(output, :row_sep => "\r\n") 
      yield csv
    }
  end
end
