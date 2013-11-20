class AddDataToProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :data, :hstore
    execute "CREATE INDEX spree_products_gist_data ON spree_products USING gin(data);"
  end
end
