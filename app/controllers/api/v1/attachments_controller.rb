module Api
  module V1
    class AttachmentsController < ApplicationController
      before_action :assign_params, only: %i[create update]

      def create
        create_attachment_form(attachment_form)
      end

      def update
        update_attachment_form(attachment_form)
      end

      def destroy
        destroy_attachment_form(attachment_form)
      end

      private

      def attachment_params
        params.require(:attachment).permit(:file)
      end

      def attachment_form
        AttachmentForm.new(attachment_attributes)
      end

      def attachment_attributes
        @attachment_attributes ||= {
          current_user: current_user,
          id: params[:id],
          parent: parent
        }
      end

      def assign_params
        attachment_attributes.merge!(params: attachment_params)
      end
    end
  end
end
