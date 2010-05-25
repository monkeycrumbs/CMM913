class InvitationsController < ApplicationController
  
  before_filter :find_survey
  before_filter :find_invitation, :only => [:show, :edit, :update, :destroy]
  
  # GET /invitations
  # GET /invitations.xml
  def index
    @invitations = @survey.invitations.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invitations }
    end
  end

  # GET /invitations/1
  # GET /invitations/1.xml
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invitation }
    end
  end

  # GET /invitations/new
  # GET /invitations/new.xml
  def new
    @invitation = Invitation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @invitation }
    end
  end

  # GET /invitations/1/edit
  def edit

  end

  # POST /invitations
  # POST /invitations.xml
  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.survey = @survey

    respond_to do |format|
      if @invitation.save
        flash[:notice] = 'Invitation was successfully created.'
        format.html { redirect_to(survey_invitation_path(@survey, @invitation)) }
        format.xml  { render :xml => @invitation, :status => :created, :location => @invitation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @invitation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /invitations/1
  # PUT /invitations/1.xml
  def update

    respond_to do |format|
      if @invitation.update_attributes(params[:invitation])
        flash[:notice] = 'Invitation was successfully updated.'
        format.html { redirect_to(survey_invitation_path(@survey, @invitation)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @invitation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /invitations/1
  # DELETE /invitations/1.xml
  def destroy
    @invitation.destroy

    respond_to do |format|
      format.html { redirect_to(survey_invitations_url(@survey)) }
      format.xml  { head :ok }
    end
  end
  
  # End of RESTful actions
  
  # Send invitation
  def invite
    @survey.send_invitations
    flash[:notice] = "Invitations have been sent"
    redirect_to(survey_invitation_path(@survey, @invitation))
  end
  
  # send follow up
  def follow_up
    @survey.send_follow_up
    flash[:notice] = "Follow ups have been sent"
    redirect_to(survey_invitation_path(@survey, @invitation))
  end
  
  private
  
  def find_survey
    @survey = Survey.find(params[:survey_id])
  end
  
  def find_invitation
    @invitation = @survey.invitations.find(params[:id])
  end
  
end
