class QueueController < ApplicationController
  def create
    conn = Bunny.new(:automatically_recover => false)
    conn.start

    ch   = conn.create_channel
    q    = ch.queue("hello")

    q.subscribe do |delivery_info, properties, body|
      
    end

    conn.close
  end
end
