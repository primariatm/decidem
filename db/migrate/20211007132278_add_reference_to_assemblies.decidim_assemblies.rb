# frozen_string_literal: true

# This migration comes from decidim_assemblies (originally 20180125104426)

class AddReferenceToAssemblies < ActiveRecord::Migration[5.1]
  def change
    add_column(:decidim_assemblies, :reference, :string)
  end
end
