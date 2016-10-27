class AddOrganizationIdToPlans < ActiveRecord::Migration[5.0]
  def change
    add_column :plans, :organization_id, :integer
  end
end
