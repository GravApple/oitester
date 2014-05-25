class AddResultToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :result, :string
  end
end
