#!/bin/bash
rake db:create
rake db:schema:load
/sbin/my_init