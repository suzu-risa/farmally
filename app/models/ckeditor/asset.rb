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

require 'active_storage'

class Ckeditor::Asset < ActiveRecord::Base
  include Ckeditor::Orm::ActiveRecord::AssetBase
  include Ckeditor::ActiveStorage

  attr_accessor :data

  has_one_attached :storage_data
end
