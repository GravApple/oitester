class AddContentToSolutions < ActiveRecord::Migration
  def change
    add_column :solutions, :content, :text
  end
end
