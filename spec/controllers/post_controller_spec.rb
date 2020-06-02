# frozen_string_literal: true

require 'spec_helper'

describe PostController do
  it 'new posts page responds with a create post form with title and body fields' do
    get '/posts/new'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Create New Post')
    expect(last_response.body).to include('Title')
    expect(last_response.body).to include('Body')
  end

  it 'successfully creates post' do
    post = { title: 'Test Post', body: 'This is a test', user_id: 1 }
    post '/posts/new', post
    expect(last_response.status).to eq(302)
  end

  it 'fails to create post with missing title' do
    post = { body: 'Test!', user_id: 1 }
    post '/posts/new', post
    expect(last_response.body).to include('Title must be provided')
  end

  it 'fails to create post with missing body' do
    post = { title: 'Test Post', user_id: 1 }
    post '/posts/new', post
    expect(last_response.body).to include('Body must be provided')
  end

  it 'fails to create post with missing user_id' do
    post = { title: 'Test Post', body: 'This is a test' }
    post '/posts/new', post
    expect(last_response.body).to include('User_id must be provided')
  end

end