module Api
  module V1
    class VideosController < ApplicationController
      before_action :assign_params, only: %i[create update]

      def create
        create_video_form(video_form)
      end

      def update
        update_video_form(video_form)
      end

      def destroy
        destroy_video_form(video_form)
      end

      private

      def video_params
        params.require(:video).permit(:clip)
      end

      def video_form
        VideoForm.new(video_attributes)
      end

      def video_attributes
        @video_attributes ||= {
          current_user: current_user,
          id: params[:id],
          parent: parent
        }
      end

      def assign_params
        video_attributes.merge!(params: video_params)
      end
    end
  end
end
