class Contest::ProblemsController < ApplicationController
  def index
    @contest = Contest.find(params[:contest_id])
    @problems = @contest.problems
  end

  def show
    @contest = Contest.find(params[:contest_id])
    @problem = @contest.problems.find(params[:id])
  end
end
