class PluginAssetsController < ApplicationController
  
  def show
    public_paths.each do |public_path|
      full_file_path = File.join(public_path, asset_directory, File.join(*params[:path]))
      if File.exist?(full_file_path)
        response.headers["Content-Type"] = content_type_for_response
        File.open(full_file_path, 'rb') { |file| render :text => file.read }
        break # break the public_paths loop when we find the first match
      end
    end
    # If the requested file isn't found in any of the paths, ActionView::MissingTemplate will
    # raise here, which results in a 404 in production.
  end
  
  protected
  
  # /stylesheets/foo/bah.css  => "css" => "text/css"
  # /images/foo/bah.png       => "png" => "image/png"
  # /javascripts/foo/bah.js   => "js"  => "text/javascript"
  def content_type_for_response
    Mime::Type.lookup_by_extension(params[:path].join("/").split(".").last).to_s
  end
  
  def public_paths
    @public_paths ||= find_public_paths_from_view_paths
  end
  
  # "/stylesheets/foo/bah.css"  => "stylesheets"
  # "/images/foo.png"           => "images"
  # "/javascripts/a/b/c/d/e.js" => "javascripts"
  def asset_directory
    request.request_uri.split("/").compact.reject(&:blank?).first
  end
  
  # Build an array of public paths (eg vendor/plugins/plugin_a/public) by looping through the 
  # view_paths array, replacing app/views with public if the view path is in vendor.
  def find_public_paths_from_view_paths
    view_paths.map { |view_path|
      view_path.to_s.gsub("app/views", "public") if view_path.to_s =~ /vendor/
    }.compact
  end
  
end