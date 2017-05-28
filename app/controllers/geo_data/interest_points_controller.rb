class GeoData::InterestPointsController < GeoData::GeoController
  def interest_points
    @points = InterestPoint.all

    unecoded_features = @points.map do |point|
      @@factory.feature(point.geom, nil, name: point.name,
                                         category: point.category,
                                         description: point.description)
    end
    encoded_features = encode_collection(unecoded_features)
    render json: encoded_features
  end
end
