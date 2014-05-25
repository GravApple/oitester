class AddCaseFieldsToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :case_num, :integer
    add_column :problems, :case_score, :integer
  end
end
