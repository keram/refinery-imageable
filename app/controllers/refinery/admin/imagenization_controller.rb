module Refinery
  module Admin
    class ImagenizationController < ::Refinery::AdminController

      def new
        @object_name = if params[:object_name].present? && params[:object_name] =~ /\A[a-z_]+\z/
                      params[:object_name]
                    else
                      :page
                    end
        render layout: false
      end

      def destroy
        if (imagenization = Refinery::Imagenization.find(params[:id].to_s)).present?
          imagenization.destroy
        end
      end

      def refinery_plugin
        @refinery_plugin ||= Refinery::Plugins['core']
      end
    end
  end
end
