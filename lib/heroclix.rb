library = %w[description combat_value power parser hero map/position map/square map/map]
library.each do |file|
  require File.dirname(__FILE__) + "/heroclix/#{file}"
end

module Heroclix
  DATA_PATH = File.dirname(__FILE__) + '/../data'
end