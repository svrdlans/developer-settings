#!/bin/bash
set -x

cd ~/projects/EventStore-OSS-MacOSX-v3.9.3
./run-node.sh --db ~/projects/elixir/fh_umbrella/ESData --run-projections=all
