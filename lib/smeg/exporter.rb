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
        write_pages
        write_index
        copy_images
        copy_public
      end
      
      private 
      def teardown
        Smeg.log.info "Removing directory: #{path}"
        FileUtils.rm_rf path
      end

      def setup
        Smeg.log.info "Creating directory"
        FileUtils.mkdir_p path
      end
      
      def write_index
        File.open("#{path}/index.html", "w") {|file| file.write(Page.find("index").render)}
      end
      
      def write_pages
        Page.all.each do |page|
          FileUtils.mkdir_p("#{path}#{page.permalink}")
          File.open("#{path}#{page.write_path}", "w"){|file| file.write(page.render) }
        end
      end
      
      def copy_images
        Smeg.log.info "Copying images"
        Page.all.each do |page|
          Smeg.log.info "Coping images for #{page.slug}"
          page.images.each do |image|
            Smeg.log.info "Copying #{image[:name]} to #{path}#{page.permalink}"
            FileUtils.cp "#{page.directory}/#{image[:name]}", "#{path}#{page.permalink}"
          end
        end
      end
      
      def copy_public
        Smeg.log.info "Copying public files"
        Dir["#{Smeg.root_dir}/public/*"].each {|file| FileUtils.cp_r file, path }
      end
    end
  end
end