class RenameTypeOnWideningParticipation < ActiveRecord::Migration[5.2]
  def change
    rename_column :widening_participations, :type, :wp_type
  end
end
