# == Schema Information
#
# Table name: ckeditor_assets
#
#  id                :bigint(8)        not null, primary key
#  data_content_type :string(255)
#  data_file_name    :string(255)      not null
#  data_file_size    :integer
#  data_fingerprint  :string(255)
#  height            :integer
#  type              :string(30)
#  width             :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_ckeditor_assets_on_type  (type)
#

class Ckeditor::Picture < Ckeditor::Asset
  include Rails.application.routes.url_helpers

  def url_content
    rails_blob_url(storage_data)
  end

  def url_thumb
    rails_representation_url(storage_data.variant(resize: "118x100"))
  end

  class << self
    def default_url_options
      Rails.application.config.action_mailer.default_url_options
    end
  end
end
