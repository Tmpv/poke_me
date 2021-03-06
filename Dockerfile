# syntax=docker/dockerfile:1
# TODO: Use alpine build as it's why more light
FROM ruby:2.7
RUN apt-get update -qq
WORKDIR /poke_me
COPY Gemfile /poke_me/Gemfile
COPY Gemfile.lock /poke_me/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
