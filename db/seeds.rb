beer_filename = Rails.root.join('dump', 'beers.json')

if File.file?(beer_filename)
  JSON.parse(File.read(beer_filename)).each do |beer|
    if style = beer['style']
      beer_style = BeerStyle.where(external_id: style['id']).first_or_initialize

      beer_style.update!(
        name:          style['name'],
        description:   style['description'],
        beer_category: style['category']['name']
      )
    else
      beer_style = nil
    end

    Beer.where(external_id: beer['id']).first_or_initialize.update!(
      name:         beer['name'],
      description:  beer['description'],
      abv:          beer['abv'],
      ibu:          beer['ibu'],
      label_icon:   beer['labels'].try(:[], 'icon'),
      label_medium: beer['labels'].try(:[], 'mediuam'),
      label_large:  beer['labels'].try(:[], 'large'),
      beer_style:   beer_style
    )
  end
end
