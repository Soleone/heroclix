# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{heroclix}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Soleone"]
  s.date = %q{2009-05-10}
  s.default_executable = %q{get_power}
  s.email = %q{soleone@gmail.com}
  s.executables = ["get_power"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION.yml",
    "bin/get_power",
    "heroclix.gemspec",
    "lib/heroclix.rb",
    "lib/heroclix/game.rb",
    "lib/heroclix/hero/base.rb",
    "lib/heroclix/hero/card.rb",
    "lib/heroclix/hero/combat_ability.rb",
    "lib/heroclix/hero/combat_value.rb",
    "lib/heroclix/hero/hero.rb",
    "lib/heroclix/hero/power.rb",
    "lib/heroclix/map/map.rb",
    "lib/heroclix/map/position.rb",
    "lib/heroclix/map/square.rb",
    "lib/heroclix/map/terrain_square.rb",
    "lib/heroclix/map/wall_square.rb",
    "lib/heroclix/parser.rb",
    "lib/heroclix/player.rb",
    "lib/monkeypatch.rb",
    "test/combat_value_test.rb",
    "test/hero_test.rb",
    "test/map_test.rb",
    "test/parser_test.rb",
    "test/player_test.rb",
    "test/power_test.rb",
    "test/square_test.rb",
    "test/test_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/Soleone/heroclix}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Software implementation of the HeroClix board game in Ruby.}
  s.test_files = [
    "test/combat_value_test.rb",
    "test/hero_test.rb",
    "test/map_test.rb",
    "test/parser_test.rb",
    "test/player_test.rb",
    "test/power_test.rb",
    "test/square_test.rb",
    "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
