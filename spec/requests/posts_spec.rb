require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'Request spec for posts index' do
    it 'returns a successful response' do
      puts "Running 'returns a successful response' test for posts index..."
      get '/users/:user_id/posts/'
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      puts "Running 'renders the correct template' test for posts index..."
      get '/users/:user_id/posts/'
      expect(response).to render_template(:index)
    end

    it 'includes the correct placeholder text in the response body' do
      puts "Running 'includes the correct placeholder text' test for posts index..."
      get '/users/:user_id/posts/'
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end

  describe 'Request spec for posts show' do
    it 'returns a successful response' do
      puts "Running 'returns a successful response' test for posts show..."
      get '/users/:user_id/posts/:id'
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      puts "Running 'renders the correct template' test for posts show..."
      get '/users/:user_id/posts/:id'
      expect(response).to render_template(:show)
    end

    it 'includes the correct placeholder text in the response body' do
      puts "Running 'includes the correct placeholder text' test for posts show..."
      get '/users/:user_id/posts/:id'
      expect(response.body).to include('Here is a single post for a user')
    end
  end
end
