class AddDataToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :data, :string
  end
end
