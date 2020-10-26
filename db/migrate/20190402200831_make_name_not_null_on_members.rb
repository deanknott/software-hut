class MakeNameNotNullOnMembers < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:members, :name, false)
  end
end
