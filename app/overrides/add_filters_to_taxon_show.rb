Deface::Override.new(:virtual_path => "spree/taxons/show",
                     :name => "add_filters_to_taxon_show",
                     :insert_top => '[data-hook="taxon_sidebar_navigation"]',
                     :partial => "spree/taxons/filters")