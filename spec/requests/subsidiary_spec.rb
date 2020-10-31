require 'rails_helper'

describe 'Subsiadiaries' do
  context 'index' do
    it 'render all subsidiaries' do
      subsidiary = create(:subsidiary)

      get '/api/v1/subsidiaries'

      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      expect(body.count).to eq 1
      expect(body[0]['name']).to eq subsidiary.name
      expect(body[0]['address']).to eq subsidiary.address
      expect(body[0]['cnpj']).to eq subsidiary.cnpj
    end

    it 'render empty json' do

      get '/api/v1/subsidiaries'

      expect(response).to be_ok
      expect(response.content_type).to include('application/json')
      expect(response.body).to eq('[]')
    end
  end
end