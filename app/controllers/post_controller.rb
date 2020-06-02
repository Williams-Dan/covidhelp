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

    %w[title body user_id].each do |required|
      next if params[required]

      @flashes.push({
        error: true,
        msg: "#{required.capitalize} must be provided"
      })
    end

    return erb :'/posts/new' unless @flashes.empty?

    Post.create!(
      title: params[:title],
      body: params[:body],
      user_id: params[:user_id]
    )

    session[:flashes] = [{ success: true, msg: 'Successfully Created!' }]
    redirect to('/')

  end
end