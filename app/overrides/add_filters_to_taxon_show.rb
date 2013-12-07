Deface::Override.new(:virtual_path => "spree/shared/_filters",
                     :name => "add_filters_to_taxon_show",
                     :insert_top => '[data-hook="navigation"]',
                     :partial => "spree/taxons/filters")