class CreateUrgencyLevels < ActiveRecord::Migration
  def change
    create_table :urgency_levels do |t|
      t.string :name, null: false, unique: true
    end
  end
end
