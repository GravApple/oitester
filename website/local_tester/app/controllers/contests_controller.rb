class ContestsController < ApplicationController
  def index
    @contests = Contest.order(id: :desc)
  end

  def new
    @contest = Contest.new
  end

  def create
    @contest = Contest.new(permit_params)
    if @contest.save
      flash[:notice] = 'Successfully created contest.'
      redirect_to contest_problems_path(@contest)
    else
      render action: :new
    end
  end

  def edit
    @contest = Contest.find(params[:id])
    @problems = @contest.problems
  end

  def update
    @contest = Contest.find(params[:id])
    if @contest.update(permit_params)
      problems = []
      params.keys.grep(/^problem_id_/).each do |problem_id_form_token|
        problem_id = params[problem_id_form_token]
        Problem.where(id: problem_id).each do |problem|
          problems << problem
        end
      end
      @contest.problems = []
      @contest.problems = problems.uniq
      flash[:notice] = 'Successfully updated contest.'
      redirect_to contest_problems_path(@contest)
    else
      render action: :edit
    end
  end

  def destroy
    @contest = Contest.find(params[:id])
    @contest.destroy
    flash[:notice] = 'Successfully deleted contest.'
    redirect_to contests_path
  end

  private

  def permit_params
    params[:contest].permit(:name)
  end
end
