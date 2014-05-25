class AddMemoryCostToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :memory_cost, :integer
  end
end
