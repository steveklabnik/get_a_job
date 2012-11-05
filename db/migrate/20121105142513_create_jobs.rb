class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :number_one
      t.integer :number_two
      t.integer :answer
      t.string :status, :null => false, :default => "processing"

      t.timestamps
    end
  end
end
