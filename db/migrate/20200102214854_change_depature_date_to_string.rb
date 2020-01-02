class ChangeDepatureDateToString < ActiveRecord::Migration[5.2]
  def change
      change_column :flights,:departure_date,:string
  end
end
