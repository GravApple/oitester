class AddDetailsToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :details, :string
  end
end
