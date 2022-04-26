class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.date       :date                 ,null: false
      t.integer    :events_select_id     ,null: false
      t.text       :met_person
      t.boolean    :checkbox
      t.references :user                 ,null: false, foreign_key: true
      t.timestamps
    end
  end
end
