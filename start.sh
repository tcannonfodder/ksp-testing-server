#!/bin/bash
( sleep 3 ; open "http://localhost:4567/step1" ) &
ruby app.rb