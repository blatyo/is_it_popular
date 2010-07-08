class PageRank < ActiveRecord::Base
  require 'page_rankr'
  require 'strscan'
  GOOGLES_BACKLINKS = {:alexa=>727036, :google=>1200000000, :bing=>211000000, :altavista=>137000000, :yahoo=>249372630, :alltheweb=>74800000}
  GOOGLES_RANKS = {:alexa=>1, :google=>10}
  BACKLINK_TRACKERS = PageRankr.backlink_trackers
  RANK_TRACKERS = PageRankr.rank_trackers
  
  validates_format_of :site, :with => /https?:\/\/[\w\.\-](:[1-9]\d*)?/, :message => "That's one ugly url. Try something prettier!"
  
  def self.clean_url(site)
    scanner = StringScanner.new site.downcase
    protocol = scanner.scan(/https?:\/\//) || "http://"
    host = scanner.check_until(/:|\/|$/).sub(/:|\//, '') || ""
    scanner.scan(/#{host}/)
    port = scanner.scan(/:[1-9]\d*/) || ""
    protocol + host + port
  end
  
  def self.create_with_stats(site)
    page_rank = self.new(:site => site)
    if page_rank.valid?
      page_rank.update_with_stats
    else
      page_rank
    end
  end
  
  def update_with_stats
    ranks = PageRankr.ranks(site)
    backlinks = PageRankr.backlinks(site)
    
    PageRankr.rank_trackers.each do |tracker|
      self.send :"#{tracker}_rank=", ranks[tracker]        #e.g. page_rank.alexa_rank = ranks[:alexa]
    end
    
    PageRankr.backlink_trackers.each do |engine|
      self.send :"#{engine}_backlinks=", backlinks[engine] #e.g. page_rank.bing_backlinks = backlinks[:bing]
    end
    
    self
  end
  
  def popular?
    popularity > 0.6
  end
  
  def popularity
    return @popularity if @popularity
    
    @popularity = PageRankr.backlink_trackers.inject(0.0) do |memo, tracker|
      memo + ((backlinks(tracker).to_f / GOOGLES_BACKLINKS[tracker].to_f) * (1.0/8.0))
    end
    
    @popularity = case rank(:google)
    when 1..10
      @popularity + rank(:google).to_f * (1.0/8.0)
    else
      @popularity
    end
    
    @popularity = case rank(:alexa)
    when 1..100000000
      @popularity + (((100000001 - rank(:alexa)).to_f / 100000000.0) * (1.0/8.0))
    else
      @popularity
    end
  end
  
  def rank(tracker)
    self.send :"#{tracker}_rank"
  end
  
  def backlinks(tracker)
    self.send :"#{tracker}_backlinks"
  end
end
