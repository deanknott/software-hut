class CreateWideningParticipations < ActiveRecord::Migration[5.2]
  def change
    create_table :widening_participations do |t|
      t.string :type

      t.timestamps
    end
  end
end
