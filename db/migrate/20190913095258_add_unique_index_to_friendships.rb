# frozen_string_literal: true

class AddUniqueIndexToFriendships < ActiveRecord::Migration[5.2]
  def change
    add_index :friendships, %i[user_id friend_id], unique: true
  end
end
