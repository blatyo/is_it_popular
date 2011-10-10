module SitesHelper
  def answer(question)
    if question
     "Yes#{content_tag :span, "!", :class => 'punctuation'}"
    else
      "No#{content_tag :span, ". :(", :class => 'punctuation'}"
    end.html_safe
  end
  
  def prettify(site)
    site = site[7..-1] if site =~ /^http:\/\//
    site = site[4..-1] if site =~ /^www\./
    site =~ /:80$/ ? site[0..-4] : site
  end

  def extravagant(stat)
    extravagant_name = content_tag :span, stat.service.gsub(/_/, ' '), :class => 'site'
    
    tag_line = if stat.backlink?
      "inbound links"
    else
      case stat.service
      when 'google'
        "page rank"
      else
        "rank"
      end
    end

    "#{extravagant_name} #{tag_line}".html_safe
  end
end
