class AddRescendedFlagToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :rescended, :boolean, default: false
  end
end
