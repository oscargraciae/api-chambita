class TestJob < ActiveJob::Base
  queue_as :default

  def perform(nombre)
    
  end
end
