module Bonsai
  class Navigation
    def self.tree
      Page.all(Page.path, "*").select{|p| !p.floating? }.sort_by{|p| p.disk_path }
    end
  end
end