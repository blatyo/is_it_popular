class Stat < ActiveRecord::Base
  GOOGLE_BACKLINKS = {'alexa' => 2597386, 'google' => 34900, 'bing' => 27100, 'yahoo' => 6376048}
  GOOGLE_RANKS     = {'google' => 10}

  belongs_to :site

  scope :backlinks, where(:kind => "backlink")
  scope :ranks,     where(:kind => "rank")

  before_save :calculate_popularity

  def backlink?
    kind == "backlink"
  end

  def rank?
    kind == "rank"
  end

  def rule
    if backlink?
      "higher is better"
    else
      case service
      when 'google'
        "10 is the best"
      else
        "1 is the best"
      end
    end
  end

private

  def calculate_popularity
    if backlink?
      self.popularity = percentage(value, GOOGLE_BACKLINKS[service])
    else
      case service
      when 'google'
        self.popularity = percentage(value, GOOGLE_RANKS[service])
      else
        self.popularity = percentage(100000000001 - (value || 100000000001), 100000000000).abs
      end
    end
  end

  def percentage(numerator, denominator)
    percentage = ((numerator || 0) * 100) / denominator
    percentage > 100 ? 100 : percentage
  end
end
