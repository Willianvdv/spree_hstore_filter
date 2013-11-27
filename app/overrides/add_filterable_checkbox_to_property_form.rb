Deface::Override.new(:virtual_path => "spree/admin/properties/_form",
                     :name => "add_filterable_checkbox_to_property_form",
                     :insert_bottom => '[data-hook="admin_property_form"]',
                     :partial => "spree/admin/properties/filterable_form_field")