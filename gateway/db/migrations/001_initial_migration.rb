class InitialMigration < Sequel::Migration
  def up
    create_table(:movies) do
      primary_key :id
      String :name, :null => false, :unique => true
      String :description, :null => false
      String :image_url, :null => false
      Date :since_at, :null => false
      Date :until_at, :null => false
    end
  end

  def down
    # You can use raw SQL if you need to
    self << 'DROP TABLE movies'
  end
end