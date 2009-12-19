require 'lib/bonsai'
require 'benchmark'

Bonsai.root_dir = File.dirname(__FILE__) + "/../spec/support"
Bonsai.configure {|config| config[:enable_logging] = false }

page = Bonsai::Page.find("about-us/history")

Benchmark.bm do |b|
  b.report "all" do
    10_000.times do
      Bonsai::Page.all
    end
  end
  
  b.report "find" do
    10_000.times do
      Bonsai::Page.find("about-us/history")
    end
  end
  
  b.report "parent" do
    10_000.times do
      page.parent
    end
  end
  
  b.report "children" do
    10_000.times do
      page.children
    end
  end
  
  b.report "siblings" do
    10_000.times do
      page.siblings
    end
  end
  
  b.report "ancestors" do
    10_000.times do
      page.ancestors
    end
  end
  
  b.report "rendering" do
    1000.times do
      page.render
    end
  end
end