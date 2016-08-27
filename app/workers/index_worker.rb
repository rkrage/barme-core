class IndexWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  attr_reader :id, :resource_class, :client

  def perform(id, klass, operation)
    @id = id
    @resource_class = klass.constantize
    @client = resource_class.__elasticsearch__.client
    send(operation)
  end

  private

  def resource_json
    resource_class.find(id).as_indexed_json
  end

  def index_document
    client.index(
      index: resource_class.index_name,
      type:  resource_class.document_type,
      id:    id,
      body:  resource_json
    )
  end

  def delete_document
    client.delete(
      index: resource_class.index_name,
      type:  resource_class.document_type,
      id:    id
    )
  end
end
