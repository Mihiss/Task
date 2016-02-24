class Content
  def self.merge
  conn = Bunny.new(:automatically_recover => false)
  conn.start

  ch   = conn.create_channel
  q    = ch.queue("main")

  q.subscribe do |delivery_info, properties, body|
    @value = "#{@value} #{body}"
  end

  conn.close
  @value
  end
end
