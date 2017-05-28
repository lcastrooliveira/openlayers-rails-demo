class GeoData::RoutesController < GeoData::GeoController

  def beach_walkway
    @route = Route.all

    unecoded_features = @route.map do |line|
      @@factory.feature(line.geom, nil, name: line.name,
                                        description: line.description)
    end
    encoded_features = encode_collection(unecoded_features)
    render json: encoded_features
  end
end
