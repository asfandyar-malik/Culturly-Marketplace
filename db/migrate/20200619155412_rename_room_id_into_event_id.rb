class RenameRoomIdIntoEventId < ActiveRecord::Migration[5.0]
    def change
        rename_column :photos, :room_id, :event_id
        rename_column :reservations, :room_id, :event_id
        rename_column :reviews, :room_id, :event_id
    end
end
