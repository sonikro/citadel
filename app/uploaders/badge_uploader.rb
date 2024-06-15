class BadgeUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def default_url
    path = 'fallback/' + [version_name, 'default_badge.png'].compact.join('_')

    ActionController::Base.helpers.asset_path path
  end

  def store_dir
    'uploads/badges'
  end

  process resize_to_fit: [64, 64]

  version :thumb do
    process resize_to_fill: [32, 32]
  end

  def extension_white_list
    %w[jpg jpeg png]
  end

  def content_type_allowlist
    %r{image/}
  end
end
