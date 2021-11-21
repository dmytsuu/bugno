class DropPlans < ActiveRecord::Migration[6.1]
  def change
    drop_table :plans if ActiveRecord::Base.connection.table_exists? :plans
  end
end
