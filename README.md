# Citadel

[![Build Status](https://github.com/ozfortress/citadel/actions/workflows/rails.yml/badge.svg)](https://github.com/ozfortress/citadel/actions)
[![codecov](https://codecov.io/gh/ozfortress/citadel/branch/master/graph/badge.svg?token=G6BlC2h9Vf)](https://codecov.io/gh/ozfortress/citadel)
[![Code Climate](https://codeclimate.com/github/ozfortress/citadel/badges/gpa.svg)](https://codeclimate.com/github/ozfortress/citadel)

Open Source, Web-based league system designed for games such as Team Fortress 2.

## Goals

* Highly configurable league system
* Full automation for regular tasks (league management/setup, etc.)
* Fine grained permission system

## Dependencies

You will need for running:

* Ruby 2.5
* Bundler
* Postgres 9.5 (configured in `config/database.yml`)
* ImageMagick

You will also need for testing:

* A js runtime supported by [execjs](https://github.com/rails/execjs)

To configure secrets (ie. steam API key) for development, use
`config/secrets.local.yml`. Example at `config/secrets.local.yml.example`.
Or put the secrets in environment variables (`SECRET_KEY_BASE`, `STEAM_API_KEY`)

## Installing

Here are some specific install instructions for operating systems/distributions.

### Ubuntu

Use either [RVM](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv) to install Ruby `2.3.3`.

Install postgres with:

```bash
sudo apt install postgresql
```

Then install all native dependencies required to install this project's gems:

```bash
sudo apt install libpq-dev imagemagick
```

Then install this project's gems:

```bash
bundle install
```

Or alternatively, if you don't want any of the test/development dependencies:

```bash
bundle install --without test development
```

If you're planning on running the test suite, you will also need to install a js runtime. Install `nodejs` like this:

```bash
sudo apt install nodejs
```

## Tests

This project uses `rspec`, `rubocop`, `haml-lint` and `rails-best-practices` for
testing and linting.

To set up the database for testing, run: `rake parallel:setup`.

All of these can be run in one command with rake:

```bash
rake
# or
rake test
```
