class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :subdomain
      t.string :auto_verify_domains
      t.boolean :auto_verify
      t.string :description
      t.string :website

      t.timestamps
    end
  end
end
