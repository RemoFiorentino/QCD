PDFKit.configure do |config|
  config.wkhtmltopdf = Gem.bin_path('wkhtmltopdf-binary', 'wkhtmltopdf')
  config.default_options = {
    :page_size => 'Legal',
    :print_media_type => true
  }
end