module SurveysHelper
  
  # returns span tag and class for survey status
  def status(survey)
    content_tag('span', survey.status, :class => survey.status.downcase )
  end
  
end
