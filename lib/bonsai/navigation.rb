module Bonsai
  class Navigation
    def self.tree
      Page.all(Page.path, "*").select{|p| !p.floating? }
    end
  end
end