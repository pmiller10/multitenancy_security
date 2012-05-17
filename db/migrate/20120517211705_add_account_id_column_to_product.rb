class AddAccountIdColumnToProduct < ActiveRecord::Migration
  def change
    add_column :products, :account_id, :integer
  end
end
