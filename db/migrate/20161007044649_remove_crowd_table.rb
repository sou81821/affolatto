class RemoveCrowdTable < ActiveRecord::Migration
  def change
    drop_table :crowds
  end
end
