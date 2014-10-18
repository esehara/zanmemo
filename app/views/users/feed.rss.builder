xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
xml.rss("version" => '2.0',
        "xmlns:dc" => 'http://purl.org/dc/elements/1.1/',
        "xmlns:atom" => 'http://www.w3.org/2005/Atom') do
  xml.channel do
    xml.title "Zanmemo :: User :: Feed :: #{@user.trace_id}"
    xml.description "by #{@user.trace_id}"
    xml.language "ja-ja"
    xml.pubDate Time.now.strftime("%a, %d %b %Y %H:%M:%S %Z")
    xml.item do
      xml.title @memo.title
      xml.guid "zanmemo.herokuapp.com/users/#{@user.trace_id}"
      xml.link "zanmemo.herokuapp.com/memo/#{@memo.created_at}"
      xml.description @memo.render
      xml.pubDate @memo.created_at.strftime("%a, %d %b %Y %H:%M:%S %Z")
      xml.author @user.trace_id
    end
  end
end
