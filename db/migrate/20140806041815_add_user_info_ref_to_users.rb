class AddUserInfoRefToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :user_info, index: true
  end
end
