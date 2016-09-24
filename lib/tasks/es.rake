namespace :es do
  desc 'Create elasticsearch indices'
  task create_indices: :environment do
    Beer.__elasticsearch__.create_index!
    Brewery.__elasticsearch__.create_index!
  end

  desc 'Delete elasticsearch indices'
  task delete_indices: :environment do
    begin
      Beer.__elasticsearch__.delete_index!
    rescue Elasticsearch::Transport::Transport::Errors::NotFound
      # ignore
    end

    begin
      Brewery.__elasticsearch__.delete_index!
    rescue Elasticsearch::Transport::Transport::Errors::NotFound
      # ignore
    end
  end

  desc 'Refresh elasticsearch indices and import data'
  task refresh_indices: :environment do
    Beer.__elasticsearch__.refresh_index!
    Beer.eager_import
    Brewery.__elasticsearch__.refresh_index!
    Brewery.eager_import
  end
end
