require 'page_rankr'

class Site < ActiveRecord::Base
  has_many :stats, :dependent => :destroy

  validates_presence_of :url, :message => "That's one ugly url. Try something prettier!"

  after_create :create_or_update_stats
  after_update :create_or_update_stats, :if => :out_of_date?

  def url=(url)
    logger.debug "#{"*" * 20} url is #{url.inspect}"
    self[:url] = PageRankr::Site(url || '').domain
  rescue PageRankr::DomainInvalid
    # Don't set
  end

  def popular?
    popularity > 60
  end

  def popularity
    return @popularity if @popularity

    @popularity = stats.to_a.inject(0) do |memo, stat|
      memo + stat.value
    end

    if @popularity.zero? || stats.count.zero?
      0
    else
      @popularity / stats.count
    end
  end

private

  def out_of_date?
    updated_at < 5.days.ago
  end

  def after_create
    create_or_update_stats
    true
  end

  def after_update
    if updated_at > 5.days.ago
      create_or_update_stats
    end

    true
  end

  def create_or_update_stats
    page_rankr_stats = {
      :rank      => PageRankr.ranks(url),
      :backlink  => PageRankr.backlinks(url)
    }

    page_rankr_stats.each do |kind, results|
      results.each do |service, value|
        if value
          stat = stats.find_or_initialize_by_kind_and_service(kind, service)
          stat.update_attributes!(:value => value)
        end
      end
    end

    true
  end
end
