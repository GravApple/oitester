class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.references :problem, index: true

      t.timestamps
    end
  end
end
