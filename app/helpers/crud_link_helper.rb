# Provide convenience link and button helpers to common CRUD operations on
# ActiveModel-compliant models. There are helper methods for new, edit, show,
# destroy and index actions, and they all come in `link_to`, `button_link_to`
# and `button_to` variants. The labels come with sensible defaults, but can be
# customized using I18n with keys suchs as `helpers.buttons.my_model.new`.
module CrudLinkHelper
  def link_to_new(model, options = {}, method_name = :link_to)
    model_name = model.model_name.param_key
    label = I18n.translate(
      :"helpers.buttons.#{model_name}.new",
      default: [:'helpers.buttons.defaults.new', 'New %{model}'],
      model: model.model_name.singular
    )
    send method_name, label, [:new, model_name], options
  end

  def link_to_index(model, options = {}, method_name = :link_to)
    model_name = model.model_name.param_key
    label = I18n.translate(
      :"helpers.buttons.#{model_name}.index",
      default: [:'helpers.buttons.defaults.index', 'Back to %{model}'],
      model: model.model_name.plural
    )
    send method_name, label, polymorphic_path(model), options
  end

  def link_to_edit(model, options = {}, method_name = :link_to)
    model_name = convert_to_model(model).class.model_name.param_key
    label = I18n.translate(
      :"helpers.buttons.#{model_name}.show",
      default: [:'helpers.buttons.defaults.show', 'Show %{model} %{id}'],
      model: convert_to_model(model).class.model_name.singular,
      id: model.to_param
    )
    send method_name, label, model, options
  end

  def link_to_edit(model, options = {}, method_name = :link_to)
    model_name = convert_to_model(model).class.model_name.param_key
    label = I18n.translate(
      :"helpers.buttons.#{model_name}.edit",
      default: [:'helpers.buttons.defaults.edit', 'Edit %{model} %{id}'],
      model: convert_to_model(model).class.model_name.singular,
      id: model.to_param
    )
    send method_name, label, [:edit, model], options
  end

  def link_to_destroy(model, options = {}, method_name = :link_to)
    confirmation = I18n.translate(
      :"helpers.buttons.#{model_name}.confirmation",
      default: [:'helpers.buttons.defaults.confirmation', 'Are you sure?'],
      model: convert_to_model(model).class.model_name.singular,
      id: model.to_param
    )
    options.reverse_merge! data: { confirm: confirmation }, method: :delete
    model_name = convert_to_model(model).class.model_name.param_key
    label = I18n.translate(
      :"helpers.buttons.#{model_name}.destroy",
      default: [:'helpers.buttons.defaults.destroy', 'Destroy %{model} %{id}'],
      model: convert_to_model(model).class.model_name.singular,
      id: model.to_param
    )
    send method_name, label, model, options
  end

  %i(index show new edit destroy).each do |action|
    define_method :"button_to_#{action}" do |model, options = {}|
      send :"link_to_#{action}", model, options, :button_to
    end

    define_method :"button_link_to_#{action}" do |model, options = {}|
      options.reverse_merge! class: 'button'
      send(:"link_to_#{action}", model, options)
    end
  end
end
