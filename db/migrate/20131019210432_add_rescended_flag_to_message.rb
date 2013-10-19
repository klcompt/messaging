class AddRescendedFlagToMessage < ActiveRecord::Migration
  def change
    add_column :messages, :rescended, :boolean
  end
end
