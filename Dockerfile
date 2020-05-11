FROM ruby:2.7.0

EXPOSE 4567

WORKDIR /tmp
COPY Gemfile /tmp
COPY Gemfile.lock /tmp

RUN gem install bundler && bundle install

RUN mkdir /app
WORKDIR /app
RUN rake db:migrate
RUN rake run

CMD ["/bin/bash"]
