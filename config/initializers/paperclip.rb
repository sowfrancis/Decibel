if Rails.env != 'test'
  Paperclip::Attachment.default_options[:path] = 'mount_prefix_for_your_app/:rails_env/:class/:attachment/:id_partition/:filename'
end