# frozen_string_literal: true

Decidim.menu(:menu) do |menu|
  menu.add_item(:buget, "Bugetare participativă", "https://decidem.primariatm.ro/bp")
  menu.move(:buget, after: :assemblies)
end
