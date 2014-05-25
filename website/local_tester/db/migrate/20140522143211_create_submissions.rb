class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.references :problem, index: true

      t.timestamps
    end
  end
end
