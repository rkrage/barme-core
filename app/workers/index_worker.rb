class IndexWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(id, klass, operation)
    klass.constantize
      .first_or_initialize_by_id(id)
      .__elasticsearch__
      .send(operation)
  end
end
