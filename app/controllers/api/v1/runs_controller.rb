class Api::V1::RunsController < Api::V1::BaseController
  before_action :requires_authentication_token
  before_action :set_run, only: %w(show update destroy)
  before_action :authorize_run

  def index
    @runs = policy_scope(Run)
    filtering_service = FilterRunsService.new from: params[:from], to: params[:to], runs: @runs

    # making a readable description to user filter
    @desc = filtering_service.description
    @runs = filtering_service.filter 

    respond_to do |format|
      format.json do
        render json: { runs: runs_hash(@runs), desc: @desc }, status: :ok
      end      
    end
  end

  def show
    respond_to do |format|
      if @run.present?
        format.json do
          render json: { run: run_hash(@run) }, status: :ok
        end
      else
        format.json do
          render json: { errors: { id: 'not found' } }, status: :not_found
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @run.update(run_params)
        format.json { render json: { run: run_hash(@run) }, status: :ok }
      else
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    respond_to do |format|
      run = Run.new run_params
      run.user_id ||= current_user.id
      if run.save
        format.json { render json: { run: run_hash(run) }, status: :created }
      else
        format.json do
          render json: { errors: run.errors }, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @run.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end  

  private

  def set_run
    # making sure that current user has access to the set run
    @run = policy_scope(Run).where(id: params[:id]).first
  end

  def authorize_run
    # authorize the set run, or the Class Run in case the run isn't initialized
    authorize (@run || Run)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def run_params
    params.require(:run).permit(policy(@run || Run).permitted_attributes)
  end  
end
