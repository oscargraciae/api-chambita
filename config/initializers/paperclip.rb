Paperclip.interpolates :file_id do |attachment, _style|
  attachment.instance.id.to_s
end
