require 'rails_helper'

RSpec.describe "Routines", type: :request do
  let!(:user) do
    User.create!(email: 'user@test.com', password: 'password')
  end

  describe "GET /index" do
    let!(:routine) do
      Routine.create! name: 'routine 01'
    end

    it 'returns status 200' do
      get '/routines'
      expect(response).to have_http_status(:ok)
    end
  
    it 'assigns @routines' do
      get '/routines'
      expect(assigns(:routines)).to eq([routine])
    end
  end

  describe 'GET /routines/:id' do
    let!(:routine) do
      Routine.create! name: 'routine 01'
    end

    it 'returns status 200' do
      get "/routines/#{routine.id}"
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @routine' do
      get "/routines/#{routine.id}"
      expect(assigns(:routine)).to eq(routine)
    end
  end

  describe 'GET /new' do
    context 'user authenticated' do
      before do
        sign_in user
      end

      it 'returns status 200' do
        get new_routine_path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'user not authenticated' do
      it 'redirects to user/sign_in' do
        get new_routine_path
        expect(response).to redirect_to new_user_session_path
      end
    end    
  end

  describe 'POST create' do
    context 'user authenticated' do
      before do
        sign_in user
      end

      it 'returns status 302' do
        post '/routines', params: { routine: { name: 'routine 01' } }
        expect(response).to have_http_status(302)
      end

      context 'with valid attributes' do
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

    context 'user not authenticated' do
      it 'redirects to user/sign_in ' do
        post '/routines', params: { routine: { name: 'routine 01' } }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET edit' do
    let!(:routine) do
      Routine.create! name: 'routine 01'
    end

    context 'user authenticated' do
      before do
        sign_in user
      end

      it 'returns status 200' do
        get edit_routine_path(routine.id)
        expect(response).to have_http_status(:ok)
      end
    end
    
    context 'user not authenticated' do
      it 'redirects to user/sign_in' do
        get edit_routine_path(routine.id)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'PATCH update' do
    before :each do
      @routine = Routine.create! name: 'routine 01'
    end

    context 'user authenticated' do
      before do
        sign_in user
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

    context 'user not authenticated' do
      it 'redirects to user/sign_in ' do
        patch routine_path(@routine), params: { routine: { name: 'Edited Routine' } }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @routine = Routine.create! name: 'routine 01'
    end

    context 'user authenticated' do
      before do
        sign_in user
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
    
    context 'user not authenticated' do
      it 'redirects to user/sign_in' do
        delete routine_path(@routine)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
