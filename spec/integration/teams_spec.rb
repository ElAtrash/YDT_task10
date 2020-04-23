require 'swagger_helper'

describe 'Teams API' do

  path '/api/v1/teams' do

    post 'Creates a team' do
      tags 'Teams'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :team, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          region: { type: :string }
        },
        required: [ 'name', 'region' ]
      }

      response '201', 'team created' do
        let(:team) { { name: 'team1', region: 'region1' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:team) { { name: nil } }
        run_test!
      end
    end
  end

  path '/api/v1/teams' do
    get 'Retrieves all Teams' do
      tags 'Teams'
      produces 'application/json'
      consumes 'application/json'

      response '200', 'Teams found' do
        schema type: :object,
        properties: {
          name: { type: :string },
          region: { type: :string }
        },
        required: [ 'name', 'region' ]
        let(:team) { { name: 'team1', region: 'region1' } }
        run_test!
      end
    end
  end

  path '/api/v1/teams/{id}' do

    get 'Retrives a team' do
      tags 'Teams'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'team found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            region: { type: :string }
          },
          required: [ 'id', 'name', 'region' ]

        let(:id) { Team.create(name: 'team1', region: 'region1').id }
        run_test!
      end

      response '404', 'team not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/teams/{id}' do
    delete 'Deletes a team' do
      tags 'Teams'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
 
      response '204', 'Team deleted' do 
        run_test!
      end

      response '404', 'Team no found' do
        run_test!
      end
    end

    patch 'Updates a team' do
      tags 'Teams'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :team, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          region: { type: :string }
        },
        required: [ 'name', 'region' ]
      }

      response '201', 'team updated' do
        let(:team) { { name: 'team2', region: 'region2' } }
        run_test!
      end

      response '404', 'team not found' do
        let(:team) { { name: 'team2' } }
        run_test!
      end

      response '401', 'invalid request' do
        let(:team) { { name: 'team2' } }
        run_test!
      end
    end
  end
end