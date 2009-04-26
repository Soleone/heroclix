library = %w[../monkeypatch hero/description hero/combat_value hero/power hero/hero data_center map/position map/map map/square map/terrain_square map/wall_square game player]
library.each do |file|
  require File.dirname(__FILE__) + "/heroclix/#{file}"
end

module Heroclix
  DATA_PATH = File.dirname(__FILE__) + '/../data'
end