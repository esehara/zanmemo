require 'qiita-markdown'

class Memo < ActiveRecord::Base
  validates :content, length: {:maximum => 1200}

  before_save do |memo|
    trace_id = Digest::SHA1.hexdigest(Time.now.to_s)
    memo.trace_id = trace_id.to_s
  end
  
  belongs_to :user

  def parse
    processer = Qiita::Markdown::Processor.new
    @markdown = processer.call(self.content)
    return self
  end

  def render
    parse
    return @markdown[:output]
  end  
end
