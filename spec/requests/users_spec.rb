require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'Request spec for users index' do
    it 'returns a successful response' do
      puts "Running 'returns a successful response' test for users index..."
      get '/users'
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      puts "Running 'renders the correct template' test for users index..."
      get '/users'
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      puts "Running 'includes the correct placeholder text' test for users index..."
      get '/users'
      expect(response.body).to include('Here is a list of all users')
    end
  end

  describe 'Request spec for users show' do
    it 'returns a successful response' do
      puts "Running 'returns a successful response' test for users show..."
      get '/users/:id'
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      puts "Running 'renders the correct template' test for users show..."
      get '/users/:id'
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      puts "Running 'includes the correct placeholder text' test for users show..."
      get '/users/:id'
      expect(response.body).to include('Here is a details of a given user')
    end
  end
end
