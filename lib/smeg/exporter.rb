module Smeg
  module Exporter
    class << self
      def path; @@path || "content"; end
      def path=(path); @@path = path; end
    end
    # Create destination output directory
    # Get all the pages, render them and deposit under the correct directories
    # Copy over anything from templates
    # 
  end
end