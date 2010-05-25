class Question < ActiveRecord::Base
  belongs_to :survey
  belongs_to :questionType, :foreign_key => :type_id
  has_many :options, :dependent => :destroy, :order => "position"
  has_many :answers, :dependent => :destroy
  acts_as_list :scope => :survey
  validates_associated :options
  validates_presence_of :title, :type_id
  
  after_update :save_options
  
  # return label_id for forms
  def label_id
    "question_id_#{self.id}"
  end
  
  # short name for question type
  def type
    self.questionType.name
  end
  
  # determine which partial template will be used depending on question type
  def partial
    "global/#{self.type}"
  end
  
  # return an array of answers
  def list_answers
    self.answers.map {|a| a.answer }
  end
  
  # return hash of answer value & count
  def answers_with_count
    count=Hash.new(0)
    self.list_answers.each {|a| count[a]+=1 }
    count
  end
  
  # return total of number answers
  def answer_total
    count = 0
    self.list_answers.each {|a| count +=a.to_i }
    count
  end
  
  # return mean average
  def answer_mean
    return if self.answers.size == 0
    self.answer_total / self.answers.size
  end
  
  # return median average
  def answer_median
    sorted = self.list_answers.sort
    mid = self.list_answers.size/2
    sorted[mid].to_i
  end
  
  # return mode average
  def answer_mode
    f = {}    # frequency table
    fmax = 0  # maximum frequency
    m = nil   # mode
    self.list_answers.each do |value|
      i = value.to_i
      f[i] ||= 0
      f[i] += 1
      fmax,m = f[i], i if f[i] > fmax
    end
    return m
  end
  
  # populate question options from form parameters
  def new_option_attributes=(option_attributes)
    option_attributes.each do |attributes|
      options.build(attributes) unless attributes['label'].blank?
    end
  end

  def existing_option_attributes=(option_attributes)
    options.reject(&:new_record?).each do |option|
      attributes = option_attributes[option.id.to_s]
      if attributes
        option.attributes = attributes
      else
        options.delete(option)
      end
    end
  end

  def save_options
    options.each do |option|
      option.save(false)
    end
  end
  
end
