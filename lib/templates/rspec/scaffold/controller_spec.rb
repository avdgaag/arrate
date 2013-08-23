require 'spec_helper'

<% module_namespacing do -%>
describe <%= controller_class_name %>Controller do

<% unless options[:singleton] -%>
  describe 'GET index' do
    describe 'response' do
      before { get :index }
      it     { should render_template('index') }
      it     { should respond_with(:success) }
    end

    it 'assigns all <%= table_name.pluralize %> as @<%= table_name.pluralize %>' do
      <%= file_name %> = create :<%= file_name %>
      get :index
      expect(assigns(:<%= table_name %>)).to eq([<%= file_name %>])
    end
  end

<% end -%>
  describe 'GET show' do
    let(:<%= file_name %>) { create :<%= file_name %> }

    describe 'response' do
      before { get :show, id: <%= file_name %>.to_param }
      it     { should render_template('show') }
      it     { should respond_with(:success) }
    end

    it 'assigns the requested <%= ns_file_name %> as @<%= ns_file_name %>' do
      get :show, id: <%= file_name %>.to_param
      expect(assigns(:<%= ns_file_name %>)).to eq(<%= file_name %>)
    end
  end

  describe 'GET new' do
    describe 'response' do
      before { get :new }
      it     { should render_template('new') }
      it     { should respond_with(:success) }
    end

    it 'assigns a new <%= ns_file_name %> as @<%= ns_file_name %>' do
      get :new
      expect(assigns(:<%= ns_file_name %>)).to be_a_new(<%= class_name %>)
    end
  end

  describe 'GET edit' do
    let(:<%= file_name %>) { create :<%= file_name %> }

    describe 'response' do
      before { get :edit, id: <%= file_name %>.to_param }
      it     { should render_template('edit') }
      it     { should respond_with(:success) }
    end

    it 'assigns the requested <%= ns_file_name %> as @<%= ns_file_name %>' do
      get :edit, id: <%= file_name %>.to_param
      expect(assigns(:<%= ns_file_name %>)).to eq(<%= file_name %>)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new <%= class_name %>' do
        expect {
          post :create, <%= ns_file_name %>: attributes_for(:<%= file_name %>)
        }.to change { <%= class_name %>.count }.by(1)
      end

      it 'assigns a newly created <%= ns_file_name %> as @<%= ns_file_name %>' do
        post :create, <%= ns_file_name %>: attributes_for(:<%= file_name %>)
        expect(assigns(:<%= ns_file_name %>)).to be_a(<%= class_name %>)
        expect(assigns(:<%= ns_file_name %>)).to be_persisted
      end

      it 'redirects to the created <%= ns_file_name %>' do
        post :create, <%= ns_file_name %>: attributes_for(:<%= file_name %>)
        expect(response).to redirect_to(<%= class_name %>.last)
      end
    end

    describe 'with invalid params' do
      before do
        <%= class_name %>.any_instance.stub(:save).and_return(false)
      end

      it 'assigns a newly created but unsaved <%= ns_file_name %> as @<%= ns_file_name %>' do
        post :create, <%= ns_file_name %>: attributes_for(:<%= file_name %>)
        expect(assigns(:<%= ns_file_name %>)).to be_a_new(<%= class_name %>)
      end

      it 're-renders the "new" template' do
        post :create, <%= ns_file_name %>: attributes_for(:<%= file_name %>)
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT update' do
    let(:<%= file_name %>) { create :<%= file_name %> }

    before do
      allow(<%= class_name %>).to receive(:find).and_return(<%= file_name %>)
    end

    describe 'with valid params' do
      it 'updates the requested <%= ns_file_name %>' do
        expect(<%= file_name %>).to receive(:update).with(attributes_for(:<%= file_name %>).stringify_keys)
        put :update, id: <%= file_name %>.to_param, <%= ns_file_name %>: attributes_for(:<%= file_name %>)
      end

      it 'assigns the requested <%= ns_file_name %> as @<%= ns_file_name %>' do
        put :update, id: <%= file_name %>.to_param, <%= ns_file_name %>: attributes_for(:<%= file_name %>)
        expect(assigns(:<%= ns_file_name %>)).to eq(<%= file_name %>)
      end

      it 'redirects to the <%= ns_file_name %>' do
        put :update, id: <%= file_name %>.to_param, <%= ns_file_name %>: attributes_for(:<%= file_name %>)
        expect(response).to redirect_to(<%= file_name %>)
      end
    end

    describe 'with invalid params' do
      before do
        allow(<%= file_name %>).to receive(:save).and_return(false)
      end

      it 'assigns the <%= ns_file_name %> as @<%= ns_file_name %>' do
        put :update, id: <%= file_name %>.to_param, <%= ns_file_name %>: attributes_for(:<%= file_name %>)
        expect(assigns(:<%= ns_file_name %>)).to eq(<%= file_name %>)
      end

      it 're-renders the "edit" template' do
        put :update, id: <%= file_name %>.to_param, <%= ns_file_name %>: attributes_for(:<%= file_name %>)
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:<%= file_name %>) { create :<%= file_name %> }

    it 'destroys the requested <%= ns_file_name %>' do
      expect {
        delete :destroy, id: <%= file_name %>.to_param
      }.to change(<%= class_name %>, :count).by(-1)
    end

    it 'redirects to the <%= table_name %> list' do
      delete :destroy, id: <%= file_name %>.to_param
      expect(response).to redirect_to(<%= index_helper %>_url)
    end
  end

end
<% end -%>
