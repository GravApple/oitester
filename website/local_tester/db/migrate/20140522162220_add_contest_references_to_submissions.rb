class AddContestReferencesToSubmissions < ActiveRecord::Migration
  def change
    add_reference :submissions, :contest, index: true
  end
end
