Beer.skip_callback(:commit, :after, :index_document)
Beer.skip_callback(:commit, :after, :index_breweries)
Brewery.skip_callback(:commit, :after, :index_document)
Brewery.skip_callback(:commit, :after, :index_beers)
BeerStyle.skip_callback(:commit, :after, :index_beers)

beer_filename = Rails.root.join('dump', 'beers.json')

if File.file?(beer_filename)
  JSON.parse(File.read(beer_filename)).each do |beer_hash|
    if style_hash = beer_hash['style']
      style = BeerStyle.where(external_id: style_hash['id']).first_or_initialize

      style.update!(
        name:          style_hash['name'],
        description:   style_hash['description'],
        beer_category: style_hash['category']['name']
      )
    else
      style = nil
    end

    if breweries_hash = beer_hash['breweries']
      breweries = breweries_hash.map do |brewery_hash|
        primary_location = brewery_hash['locations']&.detect { |loc| loc['is_primary'] == 'Y' }

        brewery = Brewery.where(external_id: brewery_hash['id']).first_or_initialize

        brewery.update!(
          name:                brewery_hash['name'],
          description:         brewery_hash['description'],
          website:             brewery_hash['website'],
          city:                primary_location.try(:[], 'locality'),
          region:              primary_location.try(:[], 'region'),
          country:             primary_location.try(:[], 'country').try(:[], 'display_name'),
          established:         brewery_hash['established'],
          image_icon:          brewery_hash['images'].try(:[], 'icon'),
          image_medium:        brewery_hash['images'].try(:[], 'medium'),
          image_large:         brewery_hash['images'].try(:[], 'large'),
          image_square_medium: brewery_hash['images'].try(:[], 'square_medium'),
          image_square_large:  brewery_hash['images'].try(:[], 'square_large'),
          brewery_type:        primary_location.try(:[], 'location_type_display')
        )

        brewery
      end.uniq { |b| b.id }
    else
      breweries = []
    end

    Beer.where(external_id: beer_hash['id']).first_or_initialize.update!(
      name:         beer_hash['name'],
      description:  beer_hash['description'],
      abv:          beer_hash['abv'],
      ibu:          beer_hash['ibu'],
      label_icon:   beer_hash['labels'].try(:[], 'icon'),
      label_medium: beer_hash['labels'].try(:[], 'medium'),
      label_large:  beer_hash['labels'].try(:[], 'large'),
      beer_style:   style,
      breweries:    breweries
    )
  end
end
