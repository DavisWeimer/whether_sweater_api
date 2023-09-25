# frozen_string_literal: true

class UpdateNameUsers < ActiveRecord::Migration[7.0]
  def change
    rename_column :users, :name, :email
  end
end
