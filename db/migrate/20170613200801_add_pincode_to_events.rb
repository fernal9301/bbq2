class AddPincodeToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :pincode, :string
  end
end
