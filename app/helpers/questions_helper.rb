module QuestionsHelper
  
  # define the option field as new or existing whilst creating/updating questions
  def fields_for_option(option, &block)
    prefix = option.new_record? ? 'new' : 'existing'
    fields_for("question[#{prefix}_option_attributes][]", option, &block)
  end

  # add an additional option label field to the question form
  def add_option_link(name) 
    link_to_function name do |page| 
      page.insert_html :bottom, :options, :partial => 'option', :object => Option.new 
    end 
  end
  
  # set the display for options
  def option_fields
    if !@question.type_id.blank? && (['select', 'radio', 'checkbox'].include? @question.type)
      'style="display:block"'
    else
      'style="display:none"'
    end
  end
  
end
