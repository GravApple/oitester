class ContestsHaveAndBelongToManyProblems < ActiveRecord::Migration
  def self.up
    create_table :contests_problems, :id => false do |t|
      t.references :contest, :problem
    end
  end

  def self.down
    drop_table :contests_problems
  end
end
