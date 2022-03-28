class CreateRoutinesExercisesJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_join_table :routines, :exercises do |t|
      t.index :routine_id
      t.index :exercise_id
    end
  end
end
