module Map
  def self.map_options
    {"auto_zoom" => true,
     "zoom" => 22,
     "zoomControl" => true,
     "mapTypeControl" => true,
     "detect_location" => true,
     "center_on_user" => false}
  end

  def self.marker_options
    {"raw" => 
    '{animation: google.maps.Animation.DROP}'}
  end
end