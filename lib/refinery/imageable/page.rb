require 'refinery/page'

Refinery::Page.send :is_imageable

Refinery::Admin::PagesController.class_eval do
  private

  def permitted_page_params_with_imagenization
    @permitted_page_params ||= permitted_page_params_without_imagenization +
                [imagenizations_attributes: [:id, :image_id, :featured, :position, image_attributes: [:id, :alt, :caption]]]
  end

  alias_method_chain :permitted_page_params, :imagenization
end

Refinery::PagesPreviewController.class_eval do
  private

  def permitted_page_params_with_imagenization
    @permitted_page_params ||= permitted_page_params_without_imagenization +
                [imagenizations_attributes: [:id, :image_id, :featured, :position, image_attributes: [:id, :alt, :caption]]]
  end

  alias_method_chain :permitted_page_params, :imagenization
end
