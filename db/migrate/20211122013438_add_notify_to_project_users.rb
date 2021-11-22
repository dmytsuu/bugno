class AddNotifyToProjectUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :project_users, :notify, :boolean, default: true, nil: false
  end
end
