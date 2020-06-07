# frozen_string_literal: true

require './config/environment'

#:nodoc:
class PostController < ApplicationController
  get '/posts/new' do
    @flashes = session.delete(:flashes) || []
    erb :'/posts/new'
  end

  post '/posts/new' do
    @flashes = session.delete(:flashes) || []

    if !session[:user_id]
      session[:flashes] = [{ msg: 'You need to be logged in to make posts' }]
      redirect to('/login')
    end

    unless User.find(session[:user_id]).verified
      @flashes.push({
        error: true,
        msg: 'You must verify your email address before posting'
      })
    end

    validate_args(%w[title body])

    return erb :'/posts/new' unless @flashes.empty?

    Post.create!(
      title: params[:title],
      body: params[:body],
      user_id: session[:user_id]
    )

    session[:flashes] = [{ success: true, msg: 'Successfully Created!' }]
    redirect to('/')
  end
end
