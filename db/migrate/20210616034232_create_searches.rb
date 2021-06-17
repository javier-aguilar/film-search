class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :query
      t.integer :count
      t.jsonb :result

      t.timestamps
    end
  end
end
