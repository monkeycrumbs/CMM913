class SurveysController < ApplicationController
  
  before_filter :admin_required
  before_filter :find_survey, :only => [:show, :edit, :update, :destroy]
  before_filter :find_relations, :only => [:new, :edit, :update, :create]
  
  # GET /surveys
  # GET /surveys.xml
  def index
    @surveys = Survey.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @surveys }
    end
  end

  # GET /surveys/1
  # GET /surveys/1.xml
  def show
    @survey = Survey.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @survey }
    end
  end

  # GET /surveys/new
  # GET /surveys/new.xml
  def new
    @survey = Survey.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @survey }
    end
  end

  # GET /surveys/1/edit
  def edit
    @survey = Survey.find(params[:id])
  end

  # POST /surveys
  # POST /surveys.xml
  def create
    @survey = Survey.new(params[:survey])
    @survey.created_by = current_user.id

    respond_to do |format|
      if @survey.save
        flash[:notice] = 'Survey was successfully created.'
        format.html { redirect_to(@survey) }
        format.xml  { render :xml => @survey, :status => :created, :location => @survey }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @survey.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /surveys/1
  # PUT /surveys/1.xml
  def update
    @survey = Survey.find(params[:id])

    respond_to do |format|
      if @survey.update_attributes(params[:survey])
        flash[:notice] = 'Survey was successfully updated.'
        format.html { redirect_to(@survey) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @survey.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.xml
  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy

    respond_to do |format|
      format.html { redirect_to(surveys_url) }
      format.xml  { head :ok }
    end
  end
  
  def preview
    # TODO update the preview functionality
    @survey_id = params[:id]
    @authenticity_token = params[:authencity_token]
    @response = Response.create(:user_id => current_user, :survey_id => @survey_id, :ip_address => request.remote_ip )
    @response.save
    
    for param in params do
      if param[0] =~ /^question_id_/
        if param[1].is_a? Hash
          param[1].each do |key, value|
            @answer = Answer.create(:question_id => $', :answer => value, :option_id => key, :response_id => @response.id) unless value == "0"
            @answer.save
          end
        else
          @answer = Answer.create(:question_id => $', :answer => param[1], :response_id => @response.id ) unless param[1].blank?
          @answer.save
        end
      end
    end
  end
  
  private
  def find_survey
    @survey = Survey.find(params[:id])
  end
  
  def find_relations
    @surveyTypes = SurveyType.find(:all)
  end
end
