module Indexable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    after_commit :index_document,  on: [:create, :update]
    after_commit :delete_document, on: :destroy

    def self.eager_import
      include_related.import
    end

    def self.serializer
      "#{name.demodulize}Serializer".constantize
    end

    def self.cached_json(id)
      __elasticsearch__.client.get(index: index_name, type: document_type, id: id)['_source']
    rescue Elasticsearch::Transport::Transport::Errors::NotFound
      nil
    end

    def index_document
      index_async(:index_document)
    end

    def delete_document
      index_async(:delete_document)
    end

    def as_indexed_json(ignore={})
      self.class.serializer.new(self).as_json
    end

    private

    def index_async(operation)
      IndexWorker.perform_async(id, self.class.name, operation)
    end
  end
end
