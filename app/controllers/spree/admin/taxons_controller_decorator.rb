Spree::Admin::TaxonsController.class_eval do
  before_filter :split_taxon_ids, only: [:new, :update]

  private
    # todo: rework this. Don't permit all params
    def taxon_params
      params.require(:taxon).permit!
    end 

    def split_taxon_ids
     if params[:taxon][:property_ids].present?
       params[:taxon][:property_ids] = params[:taxon][:property_ids].split(',')
     end
    end
end