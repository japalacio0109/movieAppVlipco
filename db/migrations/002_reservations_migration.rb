class InitialMigration < Sequel::Migration
  def up
    create_table(:reservations) do
      primary_key :id
      foreign_key :movie_id, :movies, :null => false
      Integer :position, :null => false
      Date :reservation_date, :null => false
      Datetime :created_at, :null => false
      unique [:movie_id, :position, :reservation_date]
    end
  end

  def down
    # You can use raw SQL if you need to
    self << 'DROP TABLE reservations'
  end
end