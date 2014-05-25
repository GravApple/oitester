class Contest::SubmissionsController < ApplicationController
  def index
    @contest = Contest.find(params[:contest_id])
    lim = {}
    lim[:problem_id] = params[:problem_id] if params[:problem_id]
    @submissions = @contest.submissions.where(lim).order(id: :desc)
  end

  def show
    @contest = Contest.find(params[:contest_id])
    @submission = @contest.submissions.find(params[:id])
  end

  def new
    @contest = Contest.find(params[:contest_id])
    @problem = @contest.problems.find(params[:problem_id])
    @submission = @problem.submissions.build(contest: @contest)
  end

  def create
    @contest = Contest.find(params[:contest_id])
    @problem = @contest.problems.find(params[:problem_id])
    @submission = @problem.submissions.new(permit_params)
    @submission.time_cost = -1
    @submission.memory_cost = -1
    @submission.result = 'Pending'
    if @submission.save
      flash[:notice] = 'Successfully created submission.'
      @submission.delay.judge
      redirect_to contest_submissions_path(@contest)
    else
      render action: :new
    end
  end

  def rejudge
    @contest = Contest.find(params[:contest_id])
    @submission = @contest.submissions.find(params[:id])
    if ['Pending', 'Waiting', 'Running'].include? @submission.result
      flash[:alert] = 'The submission is being judged.'
    else
      flash[:notice] = 'Successfully rejudged submission.'
      @submission.result = 'Pending'
      @submission.save
      @submission.delay.judge
    end
    redirect_to contest_submissions_path(@contest)
  end

  private

  def permit_params
    params[:submission].permit(:contest_id, :language, :code)
  end
end
