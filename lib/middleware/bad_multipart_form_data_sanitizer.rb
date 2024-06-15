class BadMultipartFormDataSanitizer
  def initialize(app)
    @app = app
  end

  # :reek:FeatureEnvy
  def call(env)
    if env['CONTENT_TYPE'] =~ %r{multipart/form-data}
      begin
        Rack::Multipart.parse_multipart(env)
      rescue EOFError
        # set content-type to multipart/form-data without the boundary part
        # to handle the case where empty content is submitted
        env['CONTENT_TYPE'] = 'multipart/form-data'
      end
    end

    @app.call(env)
  end
end
