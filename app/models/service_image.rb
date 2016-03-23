class ServiceImage < ActiveRecord::Base
  belongs_to :service

  do_not_validate_attachment_file_type :photo
  has_attached_file   :photo,
                        :styles => { :small => ["216x144!",:jpg], :meddium => ["230x230!",:jpg], :thumb => ["90x90#", :jpg]},
                        :default_style => :thumb,
                        :storage => :s3,
                        :url  => ':s3_domain_url',
                        :default_url => 'http://chambita1236.s3.amazonaws.com/uploads/users/:style/user_default.png',
                        :path => "uploads/services/:file_id/:style/:filename"
end
