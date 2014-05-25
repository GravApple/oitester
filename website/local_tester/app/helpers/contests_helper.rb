module ContestsHelper
  def contest_submissions_path_with_hash(contest, hash)
    hash[:id] = contest.id
    contest_submissions_path(hash)
  end

  def count_contest_submissions_with_hash(contest, hash)
    contest.submissions.where(hash).size
  end
end
