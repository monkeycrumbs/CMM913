class ResponsesController < ApplicationController
  
  skip_before_filter :admin_required, :except => [:index, :destroy]
  skip_before_filter :login_required, :only => [:new, :create, :show]
  before_filter :find_survey
  before_filter :check_survey, :only => [:new]
  before_filter :find_response, :only => [:show, :edit, :update, :destroy]
  
  # GET /responses
  # GET /responses.xml
  def index
    @responses = @survey.responses.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @responses }
    end
  end

  # GET /responses/1
  # GET /responses/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @response }
    end
  end

  # GET /responses/new
  # GET /responses/new.xml
  def new
    @response = Response.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @response }
    end
  end

  # GET /responses/1/edit
  def edit

  end

  # POST /responses
  # POST /responses.xml
  def create
    @response = Response.new(params[:response])
    @response.ip_address = request.remote_ip
    @response.survey_id = @survey.id
    @response.user_id = current_user
    
    for param in params do
      if param[0] =~ /^question_id_/
        # handle all question parameters
        # $' represents the value of the question_id
        if param[1].is_a? Hash
          # Valid keys include country, option, year, month, day and numeric option_id
          if param[1].has_key? "year" && "month" && "day"
            # concat year, month and day into one answer
            @response.answers.build(:question_id => $', :answer => Date.new(param[1]["year"].to_i, param[1]["month"].to_i, param[1]["day"].to_i) )
          elsif param[1].has_key? "option"
            # look up option id for radio & select questions and build answer
            option_id = Option.find_by_label_and_question_id(param[1]["option"], $').id
            @response.answers.build(:question_id => $', :answer => param[1]["option"], :option_id => option_id)
          elsif param[1].has_key? "country"
            # build country answer
            @response.answers.build(:question_id => $', :answer => param[1]["country"])
          else
            # build checkbox and likert answers
            param[1].each do |key, value|
              @response.answers.build(:question_id => $', :answer => value, :option_id => key) unless value == "0"
            end
          end
        else
          # build answer without option ie text, textarea
          @response.answers.build(:question_id => $', :answer => param[1] ) #unless param[1].blank?
        end     
      end
      if param[0] == 'token'
        @response.survey.update_invitation(param[1])
      end
    end

    respond_to do |format|
      if @response.save!
        flash[:notice] = 'Response was successfully created.'
        format.html { redirect_to([@survey, @response]) }
        format.xml  { render :xml => @response, :status => :created, :location => @response }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @response.errors, :status => :unprocessable_entity }
      end
    end
  rescue ActiveRecord::RecordInvalid => invalid
    render :action => "new"
  end

  # PUT /responses/1
  # PUT /responses/1.xml
  def update

    respond_to do |format|
      if @response.update_attributes(params[:response])
        flash[:notice] = 'Response was successfully updated.'
        format.html { redirect_to([@survey, @response]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @response.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /responses/1
  # DELETE /responses/1.xml
  def destroy
    @response.destroy

    respond_to do |format|
      format.html { redirect_to(survey_responses_url(@survey)) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_survey
    @survey = Survey.find(params[:survey_id])
  end
  
  def find_response
    @response = @survey.responses.find(params[:id])
  end
  
  def check_survey
    if @survey.status == 'Open'
      if @survey.survey_type.name == 'Private'
        login_required
      elsif @survey.survey_type.name == 'Invitation'
        if !@survey.check_token(params[:token])
          render :partial => 'invalid_token', :status => 404
          #render :file => "#{RAILS_ROOT}/public/404.html", :status => 404 and return 
        else
          @token = params[:token]
        end
      end
    else
      render :partial => 'survey_closed'
    end
  end
  
end
