class RunsController < ApplicationController
  before_action :set_run, only: [:show, :edit, :update, :destroy]
  before_action :authorize_run
  before_action :set_users, only: [:new, :create, :edit, :update]

  # GET /runs/index_spa  
  def index_spa
    @runs = policy_scope(Run).includes :user
    filtering_service = FilterRunsService.new from: params[:from], to: params[:to], runs: @runs

    # making a readable description to user filter
    desc = filtering_service.description
    set_users
    
    # setting props for React component
    @props[:runs] = Run.to_hash filtering_service.filter
    @props[:can_change_owner] = @can_change_owner
    @props[:users] = @users if @can_change_owner
    @props[:authenticity_token] = form_authenticity_token    
    @props[:filter_from] = params[:from]
    @props[:filter_to] = params[:to]
    @props[:desc_head] = desc[:head]
    @props[:desc_filter] = desc[:filter]
    @props[:current_week_stats] = Run.current_week_stats(current_user.id)
    @props[:prev_week_stats] = Run.prev_week_stats(current_user.id)
    @props[:total_stats] = Run.total_stats(current_user.id)
  end

  # GET /runs
  # GET /runs.json
  def index
    @runs = policy_scope(Run)
    filtering_service = FilterRunsService.new from: params[:from], to: params[:to], runs: @runs

    # making a readable description to user filter
    @desc = filtering_service.description
    @runs = filtering_service.filter 
  end

  # GET /runs/1
  # GET /runs/1.json
  def show
  end

  # GET /runs/new
  def new
    @run = Run.new
  end

  # GET /runs/1/edit
  def edit
  end

  # POST /runs
  # POST /runs.json
  def create
    @run = Run.new(run_params)
    # setting run owner to current user, if it isn't set
    @run.user_id ||= current_user.id
    respond_to do |format|
      if @run.save
        format.html { redirect_to @run, notice: 'Run was successfully created.' }
        format.json { render :show, status: :created, location: @run }
      else
        format.html { render :new }
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /runs/1
  # PATCH/PUT /runs/1.json
  def update
    respond_to do |format|
      if @run.update(run_params)
        format.html { redirect_to @run, notice: 'Run was successfully updated.' }
        format.json { render :show, status: :ok, location: @run }
      else
        format.html { render :edit }
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /runs/1
  # DELETE /runs/1.json
  def destroy
    @run.destroy
    respond_to do |format|
      format.html { redirect_to runs_url, notice: 'Run was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_run
      # making sure that current user has access to the set run
      @run = policy_scope(Run).where(id: params[:id]).first
    end

    def authorize_run
      # authorize the set run, or the Class User in case the run isn't initialized
      authorize (@run || Run)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def run_params
      params.require(:run).permit(policy(@run || Run).permitted_attributes)
      # params.require(:run).permit(:date, :duration, :distance, :avg_speed, :user_id)
    end

    # only crud users can change run owner, TODO check the logic behind that?!
    def set_users
      @can_change_owner = policy(@run || Run).current_user_allowed_to_crud?
      @users = policy_scope(User).map{|u| [ u.name, u.id ] } if @can_change_owner
    end
end
