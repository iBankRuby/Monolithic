# frozen_string_literal: true

class UpdateWorker
  include Sidekiq::Worker

  def update
    # Do something
  end
end
