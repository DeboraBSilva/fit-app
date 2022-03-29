require 'rails_helper'

RSpec.describe "Routines", type: :request do
  describe "GET /index" do
    it 'returns status 200' do
      get '/routines'
      expect(response).to have_http_status(:ok)
    end
  
    it 'assigns @routines' do
      routine = Routine.create name: 'routine 01'
      get '/routines'
      expect(assigns(:routines)).to eq([routine])
    end
  end

  describe 'GET /routines/:id' do
    it 'returns status 200' do
      routine = Routine.create name: 'routine 01'
      get "/routines/#{routine.id}"
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @routine' do
      routine = Routine.create name: 'routine 01'
      get "/routines/#{routine.id}"
      expect(assigns(:routine)).to eq(routine)
    end
  end

  describe 'GET /new' do
    it 'returns status 200' do
      get new_routine_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST create' do
    it 'returns status 302' do
      post '/routines', params: { routine: { name: 'routine 01' } }
      expect(response).to have_http_status(302)
    end

    context 'with valid attributes' do
      Routine.new name: 'routine 01'
      it 'creates a new routine' do
        expect do
          post '/routines', params: { routine: { name: 'routine 01' } }
        end.to change(Routine, :count).by(1)
      end

      it 'redirects to the new routine' do
        post '/routines', params: { routine: { name: 'routine 01' } }
        expect(response).to redirect_to Routine.last
      end
    end

    context 'with invalid attributes' do
      Routine.new 
      it 'does not save the new routine' do
        expect do
          post '/routines', params: { routine: { name: nil} }
        end.to_not change(Routine, :count)
      end

      it 're-renders the new method' do
        post '/routines', params: { routine: { name: nil } }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET edit' do
    it 'returns status 200' do
      routine = Routine.create name: 'routine 01'
      get edit_routine_path(routine.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH update' do
    before :each do
      @routine = Routine.create! name: 'routine 01'
    end

    context 'valid attributes' do
      it 'located the requested @routine' do
        patch routine_path(@routine), params: { routine: { name: 'Edited Routine' } }
        expect(assigns(:routine)).to eq(@routine)
      end

      it 'changes @routine attributes' do
        patch routine_path(@routine), params: { routine: { name: 'Edited Routine' } }
        @routine.reload
        expect(@routine.name).to eq('Edited Routine')
      end

      it 'redirects to the updated routine' do
        patch routine_path(@routine), params: { routine: { name: 'Edited Routine' } }
        expect(response).to redirect_to @routine
      end
    end

    context 'invalid attributes' do
      it 'locates the requested @routine' do
        patch routine_path(@routine), params: { routine: { name: nil } }
        expect(assigns(:routine)).to eq(@routine)
      end

      it 'does not change @routine attributes' do
        patch routine_path(@routine), params: { routine: { name: nil } }
        @routine.reload
        expect(@routine.name).not_to be_nil
        expect(@routine.name).to eq('routine 01')
      end

      it 're-renders the edit method' do
        patch routine_path(@routine), params: { routine: { name: nil } }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @routine = Routine.create! name: 'routine 01'
    end

    it 'deletes the routine' do
      expect  do
        delete routine_path(@routine)
      end.to change(Routine, :count).by(-1)
    end

    it 'redirects to routine#index' do
      delete routine_path(@routine)
      expect(response).to redirect_to routines_path
    end
  end
end
