require 'redcarpet'

class Memo < ActiveRecord::Base
  validates :content, length: {:maximum => 3400, :minimum => 1}

  before_save do |memo|
    if memo.trace_id == nil
      trace_id = Digest::SHA1.hexdigest(Time.now.to_s)
      memo.trace_id = trace_id.to_s
    end
  end

  before_validation do |memo|
    memo.content.strip!
  end

  belongs_to :user

  def parse
    render_config = Redcarpet::Render::HTML.new(:filter_html => true,
                                                :hard_wrap => true)
    @markdown = Redcarpet::Markdown.new(render_config)
  end

  def render
    parse
    return @markdown.render(self.content)
  end  

  def title
    title = content.split("\n")[0]
    
    if !title
      title = "(None)"
    end

    if title.length > 40
      title = title.slice(0..60) + "..."
    end

    return title
  end  
end
