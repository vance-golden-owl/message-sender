module API
    module V1
      class BlobsController < BaseController
        skip_before_action :authenticate_user!

        def create
          blob = Upload::CreateAndUploadBlobService.call(blob_params[:file])

          render_resource(blob, serializer: BlobSerializer, view: :detail, status: :created)
        end

        def show
          blob = ActiveStorage::Blob.find_signed!(params[:signed_id])

          render_resource(blob, serializer: BlobSerializer, view: :detail)
        end

        private

        def blob_params
          params.require(:blob).permit(:file)
        end
      end
    end
  end
