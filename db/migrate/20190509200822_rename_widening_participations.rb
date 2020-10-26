class RenameWideningParticipations < ActiveRecord::Migration[5.2]
  def change
    rename_table :widening_participations, :wps
  end
end
