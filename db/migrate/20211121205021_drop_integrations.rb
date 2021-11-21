class DropIntegrations < ActiveRecord::Migration[6.1]
  def change
    drop_table :integrations if ActiveRecord::Base.connection.table_exists? :integrations
  end
end
