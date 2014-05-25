class ProblemsController < ApplicationController
  def index
    @problems = Problem.order(id: :desc)
  end

  def show
    @problem = Problem.find(params[:id])
  end

  def new
    @problem = Problem.new
  end

  def create
    @problem = Problem.new(permit_params)
    if @problem.save
      flash[:notice] = 'Successfully created problem.'
      redirect_to problem_path(@problem)
    else
      render action: :new
    end
  end

  def edit
    @problem = Problem.find(params[:id])
  end

  def update
    @problem = Problem.find(params[:id])
    if @problem.update(permit_params)
      flash[:notice] = 'Successfully updated problem. Data is being synchronized in background.'
      if params[:problem][:data]
        @problem.data_synced = false
        @problem.save
        @problem.delay.sync_data if params[:problem][:data]
      end
      redirect_to problem_path(@problem)
    else
      render action: :edit
    end
  end

  def resync
    @problem = Problem.find(params[:id])
    if @problem.data?
      flash[:notice] = 'Successfully start to resynchronize data in background.'
      @problem.data_synced = false
      @problem.save
      @problem.delay.sync_data
    end
    redirect_to problems_path
  end

  def destroy
    @problem = Problem.find(params[:id])
    @problem.destroy
    flash[:notice] = 'Successfully deleted problem'
    redirect_to problems_path
  end

  private

  def permit_params
    params[:problem].permit(:name, :description, :input_format, :output_format, :sample_input, :sample_output, :hint, :data, :time_limit, :memory_limit, :case_num, :case_score)
  end
end
