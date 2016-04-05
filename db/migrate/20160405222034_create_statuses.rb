class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.boolean :is_up

      t.timestamps null: false
    end
  end
end
