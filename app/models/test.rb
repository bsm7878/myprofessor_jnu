class Test < ActiveRecord::Base
    mount_uploader :fileing, S3uploaderUploader
end
