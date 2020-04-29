require 'swagger_helper'

describe 'Users API' do

  path '/api/v1/users' do

    post 'Creates a user' do
      tags 'Users'
      parameter name: 'Authorization', in: :header, type: :string, default: 'Bearer c36e6eadde881ca7'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          phone: { type: :string },
          gender: { type: :string },
          team_id: {type: :integer},
          email: {type: :string},
          password: {type: :string}
        },
        required: [ 'name', 'phone', 'gender', 'team_id', 'email', 'password' ]
      }

      response '201', 'user created' do
        let(:user) { { name: 'user1', phone: '12345', gender: 'male', team_id: '1', email: 'user1@user.user', password: 'dsidjjisdj' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { name: nil } }
        run_test!
      end

      response '401', :unauthorized do
        let(:user) { { name: 'user1', phone: '12345', gender: 'male', team_id: '1', email: 'user1@user.user', password: 'dsidjjisdj' } }
        run_test!
      end
    end
  end

  path '/api/v1/users' do
    get 'Retrieves all Users' do
      tags 'Users'
      produces 'application/json'
      consumes 'application/json'

      response '200', 'Users found' do
        schema type: :object,
        properties: {
          name: { type: :string },
          phone: { type: :string },
          gender: { type: :string },
          team_id: {type: :integer},
          email: {type: :string}
        },
        required: [ 'name', 'phone', 'gender', 'team_id', 'email' ]
        let(:user) { { name: 'user1', phone: '12345', gender: 'male', team_id: 1, email: 'user1@user.user' } }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do

    get 'Retrives a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'user found' do
        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            phone: { type: :string },
            gender: { type: :string },
            team_id: {type: :integer},
            email: {type: :string}
          },
          required: [ 'id', 'name', 'phone', 'gender', 'team_id', 'email' ]

          let(:id) { { name: 'user1', phone: '12345', gender: 'male', team_id: 1, email: 'user@user.user' } }
          run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    delete 'Deletes a user' do
      tags 'Users'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
 
      response '204', 'User deleted' do 
        run_test!
      end

      response '404', 'User no found' do
        run_test!
      end
    end

    patch 'Updates a user' do
      tags 'Users'
      produces 'application/json'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          phone: { type: :string },
          gender: { type: :string },
          team_id: {type: :integer},
          email: {type: :string}
        },
        required: [ 'name', 'phone', 'gender', 'team_id', 'email' ]
      }

      response '201', 'user updated' do
        let(:user) { { name: 'user1', phone: '12345', gender: 'male', team_id: 1, email: 'user@user.user' } }
        run_test!
      end

      response '404', 'user not found' do
        let(:user) { { name: 'user2' } }
        run_test!
      end

      response '401', 'invalid request' do
        let(:user) { { name: 'user2' } }
        run_test!
      end
    end
  end
end