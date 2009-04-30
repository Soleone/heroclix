library = %w[../monkeypatch hero/card hero/power hero/combat_value hero/combat_ability hero/base hero/hero parser map/position map/map map/square map/terrain_square map/wall_square game player]
library.each do |file|
  require File.dirname(__FILE__) + "/heroclix/#{file}"
end

module Heroclix
  DATA_PATH = File.dirname(__FILE__) + '/../data'
end