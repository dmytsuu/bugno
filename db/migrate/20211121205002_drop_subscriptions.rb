class DropSubscriptions < ActiveRecord::Migration[6.1]
  def change
    drop_table :subscriptions if ActiveRecord::Base.connection.table_exists? :subscriptions
  end
end
