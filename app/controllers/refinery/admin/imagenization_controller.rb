module Refinery
  module Admin
    class ImagenizationController < ::Refinery::AdminController
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
