# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  # display a required marker is the question is mandatory
  def required
    @question.mandatory? ? content_tag('span', '*', :class => :required): ''
  end
  
  # display the position number of the question
  def number
    content_tag('span', @question.position.to_s + '. ', :class => :number )
  end
  
  # display the label for the question with number, title, class and for tag
  def label
    content_tag('label', number + @question.title + required, :class => @question.type, :for => @question.label_id )
  end
  
  # show the up/down image
  def move_image(direction)
    image_tag("#{direction}.gif", :alt => direction, :border => 0)
  end
  
  def help_text
    content_tag('span', @question.help_text, :class => 'info') if @question.help_text?
  end
  
  def likert_labels
    ['Strongly Agree', 'Agree', 'Neutral', 'Disagree', 'Strongly Disagree']
  end
  
end
