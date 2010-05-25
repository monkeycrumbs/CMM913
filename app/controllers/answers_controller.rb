class AnswersController < ApplicationController
  
  before_filter :find_question
  before_filter :find_answer, :only => [:show, :edit, :update, :destroy]
  
  # GET /answers
  # GET /answers.xml
  def index
    @answers = @question.answers.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @answers }
    end
  end

  # GET /answers/1
  # GET /answers/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /answers/new
  # GET /answers/new.xml
  def new
    @answer = Answer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.xml
  def create
    @answer = Answer.new(params[:answer])
    @answer.question_id = @question.id

    respond_to do |format|
      if @answer.save
        flash[:notice] = 'Answer was successfully created.'
        format.html { redirect_to(question_answer_path(@question, @answer) ) }
        format.xml  { render :xml => @answer, :status => :created, :location => @answer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /answers/1
  # PUT /answers/1.xml
  def update

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        flash[:notice] = 'Answer was successfully updated.'
        format.html { redirect_to(question_answer_path(@question, @answer)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.xml
  def destroy
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to(question_answers_url(@question)) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_question
    @question = Question.find(params[:question_id])
    @survey = @question.survey
  end
  
  def find_answer
    @answer = @question.answers.find(params[:id])
  end
end
