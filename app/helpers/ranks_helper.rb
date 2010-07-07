module RanksHelper
  def answer(question)
     (question ? "Yes<span class='punctuation'>!</span>" : "No<span class='punctuation'>. :(</span>").html_safe
  end
  
  def prettify(site)
    site = site[7..-1] if site =~ /^http:\/\//
    site = site[4..-1] if site =~ /^www\./
    site =~ /:80$/ ? site[0..-4] : site
  end
  
  def google_page_rank(page_rank)
    rank = page_rank.rank(:google)
    rank == -1 ? "N/A" : rank
  end
  
  def alexa_rank(page_rank)
    rank = page_rank.rank(:alexa)
    rank == 0 ? "N/A" : rank
  end
  
  def font_size(page_rank, tracker)
    
  end
end
