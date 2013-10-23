class AddRescindedFlagToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :rescinded, :boolean, default: false
  end
end
