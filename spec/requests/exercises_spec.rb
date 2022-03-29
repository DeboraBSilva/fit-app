require 'rails_helper'

RSpec.describe "Exercises", type: :request do
  describe "GET /index" do
    it 'returns status 200' do
      get '/exercises'
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @exercises' do
      exercise = Exercise.create description: 'exercise 01', intensity: 5
      get '/exercises'
      expect(assigns(:exercises)).to eq([exercise])
    end
  end

  describe 'GET /exercises/:id' do
    it 'returns status 200' do
      exercise = Exercise.create description: 'exercise 01', intensity: 5
      get "/exercises/#{exercise.id}"
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @exercise' do
      exercise = Exercise.create description: 'exercise 01', intensity: 5
      get "/exercises/#{exercise.id}"
      expect(assigns(:exercise)).to eq(exercise)
    end
  end

  describe 'GET /new' do
    it 'returns status 200' do
      get new_exercise_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST create' do
    it 'returns status 302' do
      post '/exercises', params: { exercise: { description: 'exercise 01', intensity: 5 } }
      expect(response).to have_http_status(302)
    end

    context 'with valid attributes' do
      Exercise.new description: 'exercise 01', intensity: 5
      it 'creates a new exercise' do
        expect do
          post '/exercises', params: { exercise: { description: 'exercise 01', intensity: 5 } }
        end.to change(Exercise, :count).by(1)
      end

      it 'redirects to the new exercise' do
        post '/exercises', params: { exercise: { description: 'exercise 01', intensity: 5 } }
        expect(response).to redirect_to Exercise.last
      end
    end

    context 'with invalid attributes' do
      Exercise.new description: 'exercise 01', intensity: 5
      it 'does not save the new exercise' do
        expect do
          post '/exercises', params: { exercise: { intensity: 5 } }
        end.to_not change(Exercise, :count)
      end

      it 're-renders the new method' do
        post '/exercises', params: { exercise: { intensity: 5 } }
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET edit' do
    it 'returns status 200' do
      exercise = Exercise.create description: 'exercise 01', intensity: 5
      get edit_exercise_path(exercise.id)
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PATCH update' do
    before :each do
      @exercise = Exercise.create! description: 'exercise 01', intensity: 5
    end

    context 'valid attributes' do
      it 'located the requested @exercise' do
        patch exercise_path(@exercise), params: { exercise: { intensity: 7 } }
        expect(assigns(:exercise)).to eq(@exercise)
      end

      it 'changes @exercise attributes' do
        patch exercise_path(@exercise), params: { exercise: { description: 'Edited Exercise', intensity: 7 } }
        @exercise.reload
        expect(@exercise.description).to eq('Edited Exercise')
        expect(@exercise.intensity).to eq(7)
      end

      it 'redirects to the updated exercise' do
        patch exercise_path(@exercise), params: { exercise: { description: 'Edited Exercise', intensity: 7 } }
        expect(response).to redirect_to @exercise
      end
    end

    context 'invalid attributes' do
      it 'locates the requested @exercise' do
        patch exercise_path(@exercise), params: { exercise: { description: nil, intensity: 7 } }
        expect(assigns(:exercise)).to eq(@exercise)
      end

      it 'does not change @exercise attributes' do
        patch exercise_path(@exercise), params: { exercise: { description: nil, intensity: 7 } }
        @exercise.reload
        expect(@exercise.description).not_to be_nil
        expect(@exercise.description).to eq('exercise 01')
        expect(@exercise.intensity).not_to eq(7)
        expect(@exercise.intensity).to eq(5)
      end

      it 're-renders the edit method' do
        patch exercise_path(@exercise), params: { exercise: { description: nil, intensity: 7 } }
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @exercise = Exercise.create! description: 'exercise 01', intensity: 5
    end

    it 'deletes the exercise' do
      expect  do
        delete exercise_path(@exercise)
      end.to change(Exercise, :count).by(-1)
    end

    it 'redirects to exercise#index' do
      delete exercise_path(@exercise)
      expect(response).to redirect_to exercises_path
    end
  end
end