#!/usr/bin/env fish

while true; curl -s http://$argv[1]; echo; sleep 1; end
