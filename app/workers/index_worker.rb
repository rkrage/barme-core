class IndexWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  attr_reader :resource

  def perform(id, klass, operation)
    @resource = klass.constantize.first_or_initialize_by_id(id)
    send(operation)
  end

  def index_document
    resource.__elasticsearch__.index_document if resource.persisted?
  end

  def delete_document
    resource.__elasticsearch__.delete_document
  end
end
