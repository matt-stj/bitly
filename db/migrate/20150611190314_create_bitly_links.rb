class CreateBitlyLinks < ActiveRecord::Migration
  def change
    create_table :bitly_links do |t|
      t.string :short_url
      t.references :campaign, index: true

      t.timestamps
    end
  end
end
