class CreateImageable < ActiveRecord::Migration
  def change
    create_table Refinery::Imagenization.table_name do |t|
      t.integer :image_id, null: false
      t.integer :imageable_id, null: false
      t.string  :imageable_type, null: false
      t.integer :position, null: false, default: 1
      t.boolean :featured, null: false, default: false
    end

    add_index Refinery::Imagenization.table_name, [:imageable_id, :imageable_type], name: 'index_on_imageable_id_and_imageable_type'
    add_index Refinery::Imagenization.table_name, [:image_id, :imageable_id, :imageable_type, :position],
                unique: true, name: 'index_on_image_id_imageable_id_imageable_type_and_position'
  end
end
