class AddLimitsToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :time_limit, :integer
    add_column :problems, :memory_limit, :integer
  end
end
