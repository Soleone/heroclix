library = %w[description combat_value power parser hero]
library.each do |file|
  require File.dirname(__FILE__) + "/heroclix/#{file}"
end