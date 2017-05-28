class GeoData::GeoController < ApplicationController
  @@factory = RGeo::GeoJSON::EntityFactory.instance
  before_action :set_default_response_format

  protected

  def encode_collection(unecoded_features)
    feature_collection = @@factory.feature_collection(unecoded_features)
    RGeo::GeoJSON.encode feature_collection
  end

  def set_default_response_format
    request.format = :json
  end
end
