module Publicious
  class Responder
  
    def self.call(env)
      request = Rack::Request.new(env)
      if request.path_info =~  %r{^\/(#{allowed_dirs.join("|")})}
        file_name = nil
        path = nil
        
        public_paths.detect do |pub_path|
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
        respond_not_found!
      end
    end
    
    def self.respond_not_found!
      Rack::Response.new("Not Found", 404).finish
    end
    
    def self.allowed_dirs
      %w(stylesheets javascripts images)
    end
    
    def self.content_type_for_file(name)
      file_name = File.basename(name).split(".").last.to_s
      Mime::Type.lookup_by_extension(file_name).to_s
    end
    
    def self.public_paths
      ::Rails::Engine.subclasses.map { |klass| 
        klass.config.paths.public.paths.first
      }.flatten.compact.reject { |path| path =~ /publicious/}
    end
    
  end
  
end