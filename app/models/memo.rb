class Memo < ActiveRecord::Base
  before_save do |memo|
    trace_id = Digest::SHA1.hexdigest(Time.now.to_s)
    memo.trace_id = trace_id.to_s
  end

  belongs_to :user
end
