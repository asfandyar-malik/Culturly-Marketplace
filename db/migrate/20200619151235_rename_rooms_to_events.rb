class RenameRoomsToEvents < ActiveRecord::Migration[5.0]
    def change
        rename_table :rooms, :events
    end
end