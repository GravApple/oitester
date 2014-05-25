class AddRenderedCodeToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :rendered_code, :text
  end
end
