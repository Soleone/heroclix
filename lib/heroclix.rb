library = %w[../monkeypatch description combat_value power parser hero map/position map/map map/square map/terrain_square map/wall_square]
library.each do |file|
  require File.dirname(__FILE__) + "/heroclix/#{file}"
end

module Heroclix
  DATA_PATH = File.dirname(__FILE__) + '/../data'
end