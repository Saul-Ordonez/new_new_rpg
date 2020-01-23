class AddBattledToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column(:characters, :battled, :string)
  end
end
