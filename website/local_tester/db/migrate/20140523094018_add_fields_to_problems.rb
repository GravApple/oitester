class AddFieldsToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :input_format, :text
    add_column :problems, :output_format, :text
    add_column :problems, :sample_input, :text
    add_column :problems, :sample_output, :text
    add_column :problems, :hint, :text
  end
end
