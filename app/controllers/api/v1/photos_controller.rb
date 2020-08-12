module Api
  module V1
    class PhotosController < ApplicationController
      before_action :assign_params, only: %i[create update]

      def create
        create_photo_form(photo_form)
      end

      def update
        update_photo_form(photo_form)
      end

      def destroy
        destroy_photo_form(photo_form)
      end

      private

      def photo_params
        params.require(:photo).permit(:image)
      end

      def photo_form
        PhotoForm.new(photo_attributes)
      end

      def photo_attributes
        @photo_attributes ||= {
          current_user: current_user,
          id: params[:id],
          parent: parent
        }
      end

      def assign_params
        photo_attributes.merge!(params: photo_params)
      end
    end
  end
end
