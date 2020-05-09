FROM ruby:2.7.0

EXPOSE 4567

WORKDIR /tmp
COPY Gemfile /tmp

RUN gem install bundler && bundle install

RUN mkdir /app
WORKDIR /app

CMD ["/bin/bash"]
