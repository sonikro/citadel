FROM phusion/passenger-ruby25

ENV RAILS_ENV production
#Update apt-get
RUN apt-get update -y
#Install dependencies
RUN apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev  libffi-dev
RUN apt-get install -y libgdbm-dev libncurses5-dev automake libtool bison libffi-dev gnupg2 libpq-dev postgresql-common libmagickwand-dev imagemagick
#Instal NodeJS
RUN curl -sL https://deb.nodesource.com/setup_11.x  | bash -
RUN apt-get -y install nodejs

#Install Bundler and download dependencies
RUN gem install bundler
RUN mkdir /citadel
WORKDIR /citadel
COPY Gemfile* ./
RUN bundle install
COPY . .
ARG SECRET_KEY_BASE 
ARG STEAM_API_KEY
ENV SECRET_KEY_BASE=${SECRET_KEY_BASE}
ENV STEAM_API_KEY=${STEAM_API_KEY}
RUN bundle exec rake DB_ADAPTER=nulldb assets:precompile
EXPOSE 80
# Start Nginx / Passenger and remove the default site
RUN rm -f /etc/service/nginx/down \
 && rm /etc/nginx/sites-enabled/default

ENTRYPOINT [ "/bin/bash", "-l", "-c", "./entrypoint.sh" ]
# Add the nginx site and config
ADD nginx.conf /etc/nginx/sites-enabled/webapp.conf

# Add files
ENV GEM_PATH /citadel/vendor/bundle/ruby/2.5.0/gems
RUN chown -R app:app /citadel

# File permissions for upload folder
RUN mkdir -p public/uploads
RUN chown -R app:app public/uploads