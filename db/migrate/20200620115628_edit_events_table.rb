class EditEventsTable < ActiveRecord::Migration[5.0]
    def change
        rename_column :events, :room_type, :event_type
        add_column :events, :description, :string
        add_column :events, :language, :string
        add_column :events, :duration, :string
        add_column :events, :location, :string
        add_column :events, :group_size, :string
        add_column :events, :what_to_bring, :string
        add_column :events, :tag, :string
    end
end
