# frozen_string_literal: true

require './config/environment'

#:nodoc:
class PostController < ApplicationController
  get '/posts/new' do
    erb :'/posts/new'
  end

  post '/posts/new' do
    unless session[:user_id]
      @flashes.push('You must be logged in to make posts')
      redirect to('/login')
    end

    unless User.find(session[:user_id]).verified
      @flashes.push('You must verify your email address before posting', :error)
    end

    validate_args(%w[title body])

    return erb :'/posts/new' unless @flashes.empty?

    Post.create!(
      title: params[:title],
      body: params[:body],
      user_id: session[:user_id]
    )

    @flashes.push("Successfully created post '#{params[:title]}'!", :success)
    redirect to('/')
  end
end
