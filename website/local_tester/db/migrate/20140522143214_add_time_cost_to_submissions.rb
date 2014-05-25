class AddTimeCostToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :time_cost, :integer
  end
end
