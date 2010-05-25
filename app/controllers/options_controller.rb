class OptionsController < ApplicationController
  
  before_filter :find_question
  before_filter :find_option, :only => [:show, :edit, :update, :destroy, :up, :down]
  
  # GET /options
  # GET /options.xml
  def index
    @options = @question.options.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @options }
    end
  end

  # GET /options/1
  # GET /options/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @option }
    end
  end

  # GET /options/new
  # GET /options/new.xml
  def new
    @option = Option.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @option }
    end
  end

  # GET /options/1/edit
  def edit

  end

  # POST /options
  # POST /options.xml
  def create
    @option = Option.new(params[:option])
    @option.question_id = @question.id

    respond_to do |format|
      if @option.save
        flash[:notice] = 'Option was successfully created.'
        format.html { redirect_to(question_option_path(@question, @option)) }
        format.xml  { render :xml => @option, :status => :created, :location => @option }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /options/1
  # PUT /options/1.xml
  def update

    respond_to do |format|
      if @option.update_attributes(params[:option])
        flash[:notice] = 'Option was successfully updated.'
        format.html { redirect_to(question_option_path(@question, @option)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @option.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /options/1
  # DELETE /options/1.xml
  def destroy
    @option.destroy

    respond_to do |format|
      format.html { redirect_to(question_options_path(@question)) }
      format.xml  { head :ok }
    end
  end
  
  # move option up
  def up
    @option.move_higher
    redirect_back_or_default(question_option_path(@question, @option))
  end
  
  # move option down
  def down
    @option.move_lower
    redirect_back_or_default(question_option_path(@question, @option))
  end
  
  private
  
  def find_question
    @question = Question.find(params[:question_id])
    @survey = @question.survey
  end
  
  def find_option
    @option = @question.options.find(params[:id])
  end
end
