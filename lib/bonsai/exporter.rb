require 'fileutils'
require 'less'

module Bonsai
  class Exporter
    @@path = "output"
    
    class << self
      def path; @@path; end
      def path=(path); @@path = path; end
      
      def process!
        setup
        copy_public
        copy_assets
        cleanup
      end
      
      def publish!
        teardown
        setup
        copy_assets
        copy_public
        compress_assets
        write_index
        write_pages
        write_sitemap
        write_readme
        cleanup
      end
      
      protected 
      def teardown
        FileUtils.rm_rf path
      end

      def setup
        FileUtils.mkdir_p path
      end
      
      def cleanup
        remove_less_sass
      end
      
      def write_index
        Bonsai.log "Writing index"
        File.open("#{path}/index.html", "w") {|file| file.write(Page.find("index").render)}
      end
      
      def write_pages
        Bonsai.log "Writing pages"
        Page.all.each do |page|
          Bonsai.log "\t Writing page - #{page.permalink}"
          FileUtils.mkdir_p("#{path}#{page.permalink}")
          File.open("#{path}#{page.write_path}", "w"){|file| file.write(page.render) }
        end
      end
      
      def write_sitemap
        Bonsai.log "Writing sitemap"
        File.open("#{path}/sitemap.xml", "w") {|file| file.write(Bonsai::Sitemap.generate) }
      end
      
      def write_readme
        Bonsai.log "Writing ABOUT-THIS-SITE"
        
        readme = <<-README
          This site was built using Bonsai (http://tinytree.info)
                
          To make changes to the site using Bonsai you will require the original source files.
          Please contact the author of your site for details.
          
          It may also be a good idea to ensure that you've got Bonsai version #{Bonsai.version} or higher.
          If you experience any unexplainable issues try uninstalling all versions of Bonsai (`gem uninstall bonsai`) and install version #{Bonsai.version} (`gem install bonsai -v #{Bonsai.version}`)
        README
        
        File.open("#{path}/ABOUT-THIS-SITE.txt", "w") {|file| file.write(readme) }
      end
      
      def copy_assets
        Bonsai.log "Copying page assets"
        Page.all.each do |page|
          page.assets.each do |asset|      
            # Create the path to the asset by the export path of the page + File.dirname(asset permalink)
            FileUtils.mkdir_p "#{path}#{File.dirname(asset[:path])}"
            
            # Copy the the asset from its disk path to File.dirname(asset permalink)
            FileUtils.cp asset[:disk_path], "#{path}#{asset[:path]}"            
          end
        end
      end
      
      def copy_public
        generate_css
        
        Bonsai.log "Copying public files"
        # Using system call because fileutils is inadequate
        system("cp -fR '#{Bonsai.root_dir}/public/.' '#{path}/.'")
      end
      
      def compress_assets
        yui_compressor = File.expand_path("#{File.dirname(__FILE__)}/../../vendor/yui-compressor/yuicompressor-2.4.2.jar")
        
        Bonsai.log "Compressing javascript and stylesheets"
        Dir["#{path}/**/*.{js,css}"].each do |asset|
          system "java -jar #{yui_compressor} #{File.expand_path(asset)} -o #{File.expand_path(asset)}"
        end
      end
      
      def generate_css
        Dir["#{Bonsai.root_dir}/public/**/*.{less,sass}"].each do |cssfile|
          css = Tilt.new(cssfile).render
          path = "#{File.dirname(cssfile)}/#{File.basename(cssfile, ".*")}.css"
          
          File.open(path, "w") {|file| file.write(css) }
        end
      rescue Less::SyntaxError => exception
        Bonsai.log "CSS Syntax error\n\n#{exception.message}"
      end
      
      def remove_less_sass
        Dir["#{path}/**/*.{less,sass}"].each{|f| FileUtils.rm(f) }
      end
    end
  end
end