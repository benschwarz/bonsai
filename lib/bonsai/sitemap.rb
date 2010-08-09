module Bonsai
  class Sitemap
    def self.generate(change_freq = "monthly")
      index = Bonsai::Page.find("index")
      
      template = Tilt::BuilderTemplate.new do
        lambda { |xml|
          xml.instruct!
          xml.urlset(:xmlns=>'http://www.sitemaps.org/schemas/sitemap/0.9') {
            xml.url {
              xml.loc(Bonsai.site[:url])
            	xml.lastmod(index.mtime.utc.strftime("%Y-%m-%d"))
            	xml.changefreq(change_freq)
           	}

            Bonsai::Page.all.delete_if{|p| p.permalink === "/index/"}.each do |page|
              xml.url {
                xml.loc(Bonsai.site[:url] + page.permalink)
              	xml.lastmod(page.mtime.utc.strftime("%Y-%m-%d"))
              	xml.changefreq(change_freq)
             	}
            end
          }
        }
      end
      
      template.render
    rescue NoMethodError
      Bonsai.log <<-HELP
      ! Can't write sitemap. Check that `site.yml` looks something like this:
      
      #{File.read(File.dirname(__FILE__) + "/templates/site.yml")}
      HELP
      
      exit
    end
  end
end
