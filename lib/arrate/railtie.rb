require 'arrate/helpers'
require 'arrate/form_builder'
require 'rails'

module Arrate
  class Railtie < ::Rails::Railtie
    initializer 'arrate.helpers' do
      ActionView::Base.send :include, Arrate::Helpers
    end

    config.action_view.default_form_builder = Arrate::FormBuilder

    config.app_generators do |g|
      g.templates.unshift File.expand_path('../templates', __FILE__)
      g.template_engine     :haml
      g.test_framework      :rspec, fixture: true, fixture_replacement: :factory_girl
      g.view_specs          true
      g.helper_specs        false
      g.helper              false
      g.javascripts         false
      g.stylesheets         false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets              false
    end
  end
end
