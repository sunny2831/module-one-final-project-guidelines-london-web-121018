class QueensMigration < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
    end

    create_table :queens do |t|
      t.string :name
      t.integer :api_key
    end

    create_table :user_queens do |t|
      t.integer :user_id
      t.integer :queen_id
    end

    create_table :tour_dates do |t|
     t.integer :queen_id
     t.string :location_date
    end

  end
end
