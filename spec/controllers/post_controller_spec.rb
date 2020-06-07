# frozen_string_literal: true

require 'spec_helper'

describe PostController do
  before :each do
    @user = User.create!(name: 'Test User', email: 'email@chat.za.net', password: 'password', verified: true)
    @non_verified_user = User.create!(name: 'Test User', email: 'email@chat.za.net', password: 'password', verified: false)
  end

  it 'new posts page responds with a create post form with title and body fields' do
    get '/posts/new'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Create New Post')
    expect(last_response.body).to include('Title')
    expect(last_response.body).to include('Body')
  end

  it 'successfully creates post' do
    post = { title: 'Test Post', body: 'This is a test' }
    post '/posts/new', post, 'rack.session' => { user_id: @user.id }
    expect(last_response.headers['Location']).to eq('http://example.org/')
  end

  it 'fails to create post with missing title' do
    post = { body: 'Test!' }
    post '/posts/new', post, 'rack.session' => { user_id: @user.id }
    expect(last_response.body).to include('Title must be provided')
  end

  it 'fails to create post with missing body' do
    post = { title: 'Test Post', user_id: 1 }
    post '/posts/new', post, 'rack.session' => { user_id: @user.id }
    expect(last_response.body).to include('Body must be provided')
  end

  it 'fails to create post when not logged in' do
    post = { title: 'Test Post', body: 'This is a test' }
    post '/posts/new', post
    expect(last_response.headers['Location']).to eq('http://example.org/login')
  end

  it 'fails to create post when email is not verified' do
    post = { title: 'Test Post', body: 'This is a test' }
    post '/posts/new', post, 'rack.session' => { user_id: @non_verified_user.id }
    expect(last_response.body).to include('You must verify your email address before posting')
  end
end
