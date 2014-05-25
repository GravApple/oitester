class AddRenderedFieldsToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :rendered_sample_input, :text
    add_column :problems, :rendered_sample_output, :text
  end
end
