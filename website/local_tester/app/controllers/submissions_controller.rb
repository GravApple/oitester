class SubmissionsController < ApplicationController
  def index
    @submissions = Submission.order(id: :desc)
  end

  def show
    @submission = Submission.find(params[:id])
  end

  def destroy
    @submission = Submission.find(params[:id])
    @submission.destroy
    flash[:notice] = 'Successfully deleted submission.'
    redirect_to submissions_path
  end
end
