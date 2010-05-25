module ResultHelper
  
  # Take a question with options and generate simple bar chart of option label answer count
  def gruff_option_image(question)
    g = Gruff::Bar.new(400)
    g.title = question.title
    
    question.options.each do |o|
      g.data(o.label, o.answers.count.to_i)
    end
    g.minimum_value = 0
    g.write("public/images/graphs/question_#{question.id}.png")
    image_tag("graphs/question_#{question.id}.png")
  end
  
  def gruff_country_image(question)
    g = Gruff::Bar.new(400)
    g.title = question.title
    question.answers_with_count.each do |answer, count|
      answer = 'No response' if answer.blank? 
      g.data(answer, count.to_i)
    end
    g.minimum_value = 0
    g.write("public/images/graphs/question_#{question.id}.png")
    image_tag("graphs/question_#{question.id}.png")
  end
  
  def percentage(option, question)
    sprintf( "%8.2f%",(option.answers.count.to_f / question.answers.count.to_f) * 100)
  end
  
  def gruff_likert_image(option)
    g = Gruff::Bar.new(400)
    g.title = option.label
    likert_labels.each do |label|
      g.data(label, option.answers.find_all_by_answer(label).size)
    end
    g.minimum_value = 0
    g.write("public/images/graphs/question_#{option.question.id}_option_#{option.id}.png")
    image_tag("graphs/question_#{option.question.id}_option_#{option.id}.png")
  end
  
end
