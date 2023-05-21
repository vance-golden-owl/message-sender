module Upload
    class CreateAndUploadBlobService < ApplicationService
      attr_reader :file

      def initialize(file)
        @file = file
      end

      def call
        validate_file!
        create_and_upload!
      end

      private

      def allowed_content_types
        %r{image/\w+|video/\w+|audio/\w+}
      end

      def validate_file!
        unless allowed_content_types.match?(file.content_type)
          raise APIError::BadRequestError, 'Invalid content type, submit content must be image, video or audio'
        end

        if file.size > 100.megabytes
          raise APIError::BadRequestError, 'File size is too large, can not be greather than 100MB'
        end
      end

      def create_and_upload!
        ActiveStorage::Blob.create_and_upload!(
          io: file.open,
          filename: file.original_filename,
          content_type: file.content_type
        )
      end
    end
  end
