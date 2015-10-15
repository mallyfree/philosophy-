

class WikiFile < ActiveRecord::Migration
  def change
    create_table :page do |t|
      t.string :title
      t.string :url
      t.text :prelude
      t.text :preview
    end

    def change
      create_table :link do |t|
        t.text :from_page_id
        t.text :to_page_id
      end


  end
end
