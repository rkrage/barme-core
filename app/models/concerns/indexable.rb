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
      __elasticsearch__.index_document
    end

    def update_document
      __elasticsearch__.update_document
    end

    def delete_document
      __elasticsearch__.delete_document
    end

    def as_indexed_json(ignore)
      self.class.serializer.new(self).as_json
    end
  end
end
