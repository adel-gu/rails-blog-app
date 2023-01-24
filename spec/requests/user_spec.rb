require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    before (:example) { get '/users' }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'to render the :index template' do
      expect(response).to render_template(:index)
    end

    it 'display header in the body response' do
      expect(response.body).to include("Here is a list of users")
    end

  end
end
