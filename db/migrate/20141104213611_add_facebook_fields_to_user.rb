class AddFacebookFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :name, :string
    add_column :users, :first, :string
    add_column :users, :image, :string
    add_column :users, :token, :string
    add_column :users, :expires_at, :datetime
    add_column :users, :password_digest, :string
  end
end
