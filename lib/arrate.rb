require 'arrate/version'
require 'rails'

module Arrate
  module Rails
    class Railtie < ::Rails::Railtie
      config.app_generators do |g|
        g.templates.unshift File.expand_path('../templates', __FILE__)
        g.template_engine     :haml
        g.test_framework      :rspec, fixture: true, fixture_replacement: :factory_girl
        g.view_specs          false
        g.helper_specs        false
        g.helper              false
        g.javascripts         false
        g.stylesheets         false
        g.fixture_replacement :factory_girl, dir: 'spec/factories'
        g.assets              false
      end
    end
  end
end
