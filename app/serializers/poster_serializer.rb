class PosterSerializer
  def self.format_posters(posters)
    {
      data: posters.map do |poster|
        {
          id: poster.id,
          name: poster.name,
          description: poster.description,
          price: poster.price,
          year: poster.year,
          vintage: poster.vintage,
          img_url: poster.img_url
        }
      end
    }
  end
end
