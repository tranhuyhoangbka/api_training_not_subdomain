class ChangeDefaultValuesToProducts < ActiveRecord::Migration
  def change
    change_column :products, :title, :string, default: ""
    change_column :products, :price, :decimal, default: 0.0
    change_column :products, :published, :boolean, default: false
  end
end
