class AddPickedUpToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column(:characters, :picked_up, :string)
  end
end
