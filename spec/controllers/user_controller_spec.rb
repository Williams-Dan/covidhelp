# frozen_string_literal: true

require 'spec_helper'

describe UserController do
  # Register
  it 'register responds with a registeration form with name email and password fields' do
    get '/register'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Register Form')
    expect(last_response.body).to include('Name')
    expect(last_response.body).to include('Email')
    expect(last_response.body).to include('Password')
    expect(last_response.body).to include('Confirm Password')
  end

  it 'registers a new user successfully' do
    user = { name: 'Test User', email: 'email@chat.za.net', password: 'password', passwordConfirm: 'password' }
    post '/register', user
    expect(last_response.status).to eq(302)
  end

  it 'fails to register user with missing name' do
    user = { email: 'email@chat.za.net', password: 'password', passwordConfirm: 'password' }
    post '/register', user
    expect(last_response.body).to include('Name must be provided')
  end

  it 'fails to register user with missing email' do
    user = { name: 'Test User', password: 'password', passwordConfirm: 'password' }
    post '/register', user
    expect(last_response.body).to include('Email must be provided')
  end

  it 'fails to register user with missing password' do
    user = { name: 'Test User', email: 'email@chat.za.net', passwordConfirm: 'password' }
    post '/register', user
    expect(last_response.body).to include('Password must be provided')
  end

  it 'fails to register user with missing confirm password' do
    user = { name: 'Test User', email: 'email@chat.za.net', password: 'password' }
    post '/register', user
    expect(last_response.body).to include('Passwords do not match')
  end

  it 'fails to register user with where password and confirm do not match' do
    user = { name: 'Test User', email: 'email@chat.za.net', password: 'password', passwordConfirm: 'oopsie_password' }
    post '/register', user
    expect(last_response.body).to include('Passwords do not match')
  end

  it 'fails to register user with where email is invalid' do
    user = { name: 'Test User', email: 'oopsie_email', password: 'password', passwordConfirm: 'password' }
    post '/register', user
    expect(last_response.body).to include('Not a valid email address')
  end

  it 'fails to register user with where email is already registered' do
    user = { name: 'Test User', email: 'email@chat.za.net', password: 'password' }
    User.create!(user)
    user[:passwordConfirm] = 'password'
    post '/register', user
    expect(last_response.headers['Location']).to eq('http://example.org/login')
  end

  # Login
  it 'login responds with a login form' do
    get '/login'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include('Login Form')
  end

  it 'logs in successfully' do
    user = { email: 'email@chat.za.net', password: 'password' }
    post '/login', user
    expect(last_response.status).to eq(200)
  end

  it 'fails to login with no email' do
    user = { password: 'password' }
    post '/login', user
    expect(last_response.body).to include('Email must be provided')
  end

  it 'fails to login with no password' do
    user = { email: 'email@chat.za.net' }
    post '/login', user
    expect(last_response.body).to include('Password must be provided')
  end

  it 'fails to login with wrong password' do
    user = { email: 'email@chat.za.net', password: 'wr0ng' }
    post '/login', user
    expect(last_response.body).to include('Email or password is incorrect')
  end

  it 'fails to login with wrong email' do
    user = { email: 'incorrect@chat.za.net', password: 'password' }
    post '/login', user
    expect(last_response.body).to include('Email or password is incorrect')
  end
end
