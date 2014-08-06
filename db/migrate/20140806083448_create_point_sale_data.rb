class CreatePointSaleData < ActiveRecord::Migration
  def change
    create_table :point_sale_data do |t|
      t.datetime :datetime
      t.string :code
      t.float :value

      t.timestamps
    end
  end
end
