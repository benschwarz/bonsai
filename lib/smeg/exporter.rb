require 'fileutils'

module Smeg
  module Exporter
    @@path = "output"
    
    class << self
      def path; @@path; end
      def path=(path); @@path = path; end
            
      def publish!
        teardown
        setup
        copy_assets
        copy_public
        write_index
        write_pages
      end
      
      private 
      def teardown
        Smeg.log.debug "Removing directory: #{path}"
        FileUtils.rm_rf path
      end

      def setup
        Smeg.log.debug "Creating directory"
        FileUtils.mkdir_p path
      end
      
      def write_index
        Smeg.log.debug "Writing Index"
        File.open("#{path}/index.html", "w") {|file| file.write(Page.find("index").render)}
      end
      
      def write_pages
        Page.all.each do |page|
          Smeg.log.debug "Writing page: #{page.permalink}"
          FileUtils.mkdir_p("#{path}#{page.permalink}")
          File.open("#{path}#{page.write_path}", "w"){|file| file.write(page.render) }
        end
      end
      
      def copy_assets
        Smeg.log.info "Copying images"
        Page.all.each do |page|
          Smeg.log.info "Copying images for #{page.slug}"
          page.assets.each do |asset|
            Smeg.log.info "Copying #{asset[:name]} to #{path}#{page.permalink}"
            
            # Create the path to the asset by the export path of the page + File.dirname(asset permalink)
            FileUtils.mkdir_p "#{path}#{File.dirname(asset[:path])}"
            
            # Copy the the asset from its disk path to File.dirname(asset permalink)
            FileUtils.cp asset[:disk_path], "#{path}#{asset[:path]}"            
          end
        end
      end
      
      def copy_public
        Smeg.log.debug "Copying public files"
        Dir["#{Smeg.root_dir}/public/*"].each {|file| FileUtils.cp_r file, path }
      end
    end
  end
end