Mime::Type.register "image/jpeg", :jpg
Mime::Type.register "image/gif", :gif
Mime::Type.register "image/png", :png

class Publicious
  FILE_METHODS = %w(GET HEAD).freeze

  def initialize(app)
    @app = app
    yield if block_given?
  end

  def klass
    self.class
  end

  def call(env)
    request = Rack::Request.new(env)
    return @app.call(env) unless FILE_METHODS.include?(request.request_method)

    if request.path_info =~  %r{^\/(#{klass.allowed_dirs.join("|")})}
      file_name = nil
      path = nil

      klass.public_paths.detect do |pub_path|
        path = pub_path
        fp   = File.join(pub_path, request.path_info)
        file_name = fp if File.file?(fp)
      end

      return respond_not_found! unless file_name

      # Make sure pricks aren't ../../config/database.yml ing us
      respond_not_found! unless file_name.gsub(%r[^#{path}], "") == request.path_info

      Rack::Response.new(
        File.open(file_name),
        200,'Content-Type' => content_type_for_file(file_name)
      ).finish
    else
      @app.call(env)
    end
  end

  def respond_not_found!
    Rack::Response.new("Not Found", 404).finish
  end

  def content_type_for_file(name)
    file_name = File.basename(name).split(".").last.to_s
    Mime::Type.lookup_by_extension(file_name).to_s
  end

  def self.allowed_dirs
    %w(stylesheets javascripts images)
  end

  def self.public_paths
    @public_paths ||= begin
      paths = []
      paths += add_engines_public_paths! if defined?(::Rails::Engine)
      paths
    end
  end

  def self.add_engines_public_paths!
    ::Rails::Engine.subclasses.map { |klass|
      klass.config.paths.public.paths.first
    }.flatten.compact.reject { |path| path =~ /publicious/}
  end
end

