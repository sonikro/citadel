FROM ubuntu:16.04

#Update apt-get
RUN apt-get update -y
#Install dependencies
RUN apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
RUN apt-get install -y libgdbm-dev libncurses5-dev automake libtool bison libffi-dev gnupg2 libpq-dev postgresql-common libmagickwand-dev imagemagick
#Instal NodeJS
RUN curl -sL https://deb.nodesource.com/setup_11.x  | bash -
RUN apt-get -y install nodejs
#Install RVM
RUN gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s stable
#CHange default shell to consider rvm
SHELL [ "/bin/bash", "-l", "-c" ]
#Install Ruby 2.5.0
RUN rvm install 2.5.0
RUN rvm use 2.5.0 --default
#Install Bundler and download dependencies
RUN gem install bundler
RUN mkdir /citadel
WORKDIR /citadel
COPY Gemfile* ./
RUN bundle install

COPY . .
EXPOSE 3000
ENTRYPOINT [ "/bin/bash", "-l", "-c", "./entrypoint.sh" ]