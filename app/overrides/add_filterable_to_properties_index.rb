Deface::Override.new(:virtual_path => "spree/admin/properties/index",
                     :name => "add_filterable_to_property_index_th",
                     :insert_before => '#listing_properties thead th.actions',
                     :text => "<th><%= t(:filterable) %></th>")

Deface::Override.new(:virtual_path => "spree/admin/properties/index",
                     :name => "add_filterable_to_property_index_td",
                     :insert_before => '#listing_properties tbody td.actions',
                     :text => "<th><%= 'True' if property.filterable %></th>")