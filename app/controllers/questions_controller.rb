class QuestionsController < ApplicationController
  
  before_filter :find_survey
  before_filter :find_question, :only => [:show, :edit, :update, :destroy, :up, :down]
  
  # GET /questions
  # GET /questions.xml
  def index
    @questions = @survey.questions.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new
    @question.options.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit

  end

  # POST /questions
  # POST /questions.xml
  def create
    @question = Question.new(params[:question])
    @question.survey = @survey

    respond_to do |format|
      if @question.save
        flash[:notice] = 'Question was successfully created.'
        format.html { redirect_to(survey_question_path(@survey, @question))}
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
     params[:question][:existing_option_attributes] ||= {}

    respond_to do |format|
      if @question.update_attributes(params[:question])
        flash[:notice] = 'Question was successfully updated.'
        format.html { redirect_to(survey_question_path(@survey, @question)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(survey_questions_url(@survey)) }
      format.xml  { head :ok }
    end
  end
  
  # move question up
  def up
    @question.move_higher
    redirect_back_or_default(survey_question_path(@survey, @question))
  end
  
  # move question down
  def down
    @question.move_lower
    redirect_back_or_default(survey_question_path(@survey, @question))
  end
  
  private
  
  def find_survey
    @survey = Survey.find(params[:survey_id])
    @questionTypes = QuestionType.find(:all)
  end
  
  def find_question
    @question = @survey.questions.find(params[:id])
  end
  
end
