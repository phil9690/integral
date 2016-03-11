# CKEditor picture
class Ckeditor::Picture < Ckeditor::Asset
  mount_uploader :data, CkeditorPictureUploader, :mount_on => :data_file_name

  # @return [String] url content (?)
  def url_content
    url(:content)
  end
end
