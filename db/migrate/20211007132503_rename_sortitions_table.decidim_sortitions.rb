# frozen_string_literal: true

# This migration comes from decidim_sortitions (originally 20180108132729)

class RenameSortitionsTable < ActiveRecord::Migration[5.1]
  def change
    rename_table(:decidim_module_sortitions_sortitions, :decidim_sortitions_sortitions)
  end
end
