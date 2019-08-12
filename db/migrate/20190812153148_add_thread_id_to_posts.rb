class AddThreadIdToPosts < ActiveRecord::Migration[5.2]
  def change
    change_table :posts do |t|
      t.belongs_to :topic, index: true
    end
  end
end
