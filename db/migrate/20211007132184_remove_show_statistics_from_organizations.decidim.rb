# frozen_string_literal: true

# This migration comes from decidim (originally 20200929171508)

class RemoveShowStatisticsFromOrganizations < ActiveRecord::Migration[5.2]
  def change
    remove_column(:decidim_organizations, :show_statistics)
  end
end
