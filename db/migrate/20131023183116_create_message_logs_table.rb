class CreateMessageLogsTable < ActiveRecord::Migration
  def change
    create_table :message_logs do |t|
      t.string :from
      t.datetime :called_at
      t.integer :message_id
    end
  end
end
