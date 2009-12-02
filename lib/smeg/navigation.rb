module Smeg
  class Navigation
    def self.tree
      Page.all(Page.path, "*").select{|p| File.dirname(p.disk_path).match(/\d.*$/) }
    end
  end
end