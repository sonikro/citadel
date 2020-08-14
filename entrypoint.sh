#!/bin/bash
rake db:create
rake db:schema:load
rails s -p 3000 -b 0.0.0.0