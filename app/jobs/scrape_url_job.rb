class ScrapeUrlJob < ApplicationJob
  def perform(link)
    site = MetaInspector.new(link.url)
    link.update! title: site.best_title,
      description: site.best_description,
      image_url: site.images.best
  end
end
