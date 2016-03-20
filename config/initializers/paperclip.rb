if Rails.env.development?
	Paperclip::Attachment.default_options[:url] = "/system/:class/:attachment/:id/:style/:basename.:extension"
	Paperclip::Attachment.default_options[:path] = ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension"
else
	Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
	Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
end


