require 'rspec_api_documentation/dsl'

resource 'Run', :type => :api, focus: true do
  let(:run) { build :run }
  let(:user) { build :user_with_token }
  let(:admin_user) { build :user_with_token, :admin }
  let(:user_run) { build :run, user: user }
  let(:admin_run) { build :run, user: admin }

  post '/api/v1/runs', format: :json do
    before { user.save }

    header 'AUTHORIZATION', :token

    parameter :date, 'Date', required: true, scope: :run
    parameter :duration, 'Duration in minutes', required: true, scope: :run
    parameter :distance, 'Distance in meters', required: true, scope: :run

    let(:token) { ActionController::HttpAuthentication::Token.encode_credentials user.user_tokens.first.try(:access_token) }
    let(:date) { run.name }
    let(:duration) { run.duration }
    let(:distance) { run.distance }

    example_request 'create a new run for the authenticated user' do
      response_json = JSON.parse response_body

      expect(status).to eq(201)
      expect(response_json['run']).to have_key('id')
      expect(response_json['run']).to have_key('avg_speed')
      expect(response_json['run']).to have_key('user_id')
      expect(response_json['run']).to have_key('duration')
      expect(response_json['run']['duration']).to eq run.duration
      # expect owner of the run to be the authenticated user
      expect(response_json['run']['user_id']).to eq user.id
    end

    example 'create with error', document: false do
      do_request params.tap { |parameters| parameters['run']['date'] = nil }
      response_json = JSON.parse response_body

      expect(status).to eq(422)
      expect(response_json['errors']).to have_key('date')
    end
  end

  get '/api/v1/runs', format: :json, document: false do
    before { user.save }

    example_request 'index without authentication' do
      response_json = JSON.parse response_body
      # user should be authenticated first, before listing runs
      expect(status).to eq 401
    end
  end

  get '/api/v1/runs', format: :json do
    before { 
      admin_user.save 
      admin_run.save
      user_run.save
    }

    header 'AUTHORIZATION', :token

    let(:token) { ActionController::HttpAuthentication::Token.encode_credentials admin_user.user_tokens.first.try(:access_token) }

    example_request 'index runs with admin user' do
      response_json = JSON.parse response_body

      expect(status).to eq 200
      expect(response_json).to have_key('runs')
      # admin can list all runs, not only his
      expect(response_json["runs"].count).to eq Run.count
      expect(response_json["runs"].count).not_to eq admin_user.runs.count
    end
  end

  get '/api/v1/runs', format: :json do
    before { 
      admin_user.save 
      user_run.save
      admin_run.date = '2017-05-13'
      admin_run.save
    }

    header 'AUTHORIZATION', :token

    parameter :from, 'Date to filter runs from', required: false
    parameter :to, 'Date to filter runs to', required: false

    let(:token) { ActionController::HttpAuthentication::Token.encode_credentials admin_user.user_tokens.first.try(:access_token) }
    let(:from) { '2017-05-14' }
    let(:to) { '2017-05-17' }

    example_request 'index runs with admin user with filters' do
      response_json = JSON.parse response_body

      expect(status).to eq 200
      expect(response_json).to have_key('runs')
      # admin can list all runs, not only his
      expect(response_json["runs"].count).to eq Run.between(from, to).count
      expect(response_json["runs"]).not_to include admin_run
    end
  end

  get '/api/v1/runs', format: :json do
    before { 
      admin_user.save 
      admin_run.save
      user_run.save
    }

    header 'AUTHORIZATION', :token

    let(:token) { ActionController::HttpAuthentication::Token.encode_credentials admin_user.user_tokens.first.try(:access_token) }

    example_request 'index runs with normal user' do
      response_json = JSON.parse response_body

      expect(status).to eq 200
      expect(response_json).to have_key('runs')
      expect(response_json["runs"].count).to eq user.runs.count
      expect(response_json["runs"].count).not_to eq Run.count
    end
  end

  get '/api/v1/runs/:id', format: :json do
    before { 
      user.save 
      run.save
    }

    header 'AUTHORIZATION', :token

    parameter :id, 'Run Unique Identifier', required: true

    let(:token) { ActionController::HttpAuthentication::Token.encode_credentials user.user_tokens.first.try(:access_token) }
    let(:id) { run.id }

    example_request 'show' do
      response_json = JSON.parse response_body

      expect(status).to eq 200
      expect(response_json['run']).to have_key('id')
      expect(response_json['run']).to have_key('user')
    end
  end

  put '/api/v1/runs/:id', format: :json do
    before { 
      user.save 
      run.save
    }

    header 'AUTHORIZATION', :token

    parameter :id, 'Run Unique Identifier', required: true
    parameter :duration, 'Updated Duration', scope: :run    

    let(:token) { ActionController::HttpAuthentication::Token.encode_credentials user.user_tokens.first.try(:access_token) }
    let(:id) { run.id }
    let(:duration) { new_duration }
    let(:old_duration) { run.duration }
    let(:new_duration) { run.duration*2 }

    example_request 'update' do
      response_json = JSON.parse response_body

      expect(status).to eq 200
      expect(response_json['run']).to have_key('id')

      updated_run = Run.find(response_json['run']['id'])

      expect(response_json['run']).to have_key('duration')
      # make sure the returned value is correct
      expect(response_json['run']['duration']).to eq new_duration
      # make sure the saved value is correct
      expect(updated_run.duration).to eq new_duration
      expect(updated_run.duration).not_to eq old_duration
    end
  end
end
