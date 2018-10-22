class AddDefaultValueToConfirmMembership < ActiveRecord::Migration[5.2]
  change_column_default(
    :memberships,
    :confirmed,
    true 
  )
end
