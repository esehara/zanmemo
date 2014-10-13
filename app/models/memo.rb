require 'redcarpet'

class Memo < ActiveRecord::Base
  validates :content, length: {:maximum => 1200}

  before_save do |memo|
    trace_id = Digest::SHA1.hexdigest(Time.now.to_s)
    memo.trace_id = trace_id.to_s
  end
  
  belongs_to :user

  def parse
    @markdown = RedCarpet::Markdown::Processor.new(Redcarpet::Render::HTML)
  end

  def render
    parse
    return @markdown.render(self.content)
  end  
end
