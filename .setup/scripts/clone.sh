#!/bin/bash

git clone git@github.com:ijapesigan/docker-pymc.git
rm -rf "$PWD.git"
mv docker-pymc/.git "$PWD"
rm -rf docker-pymc
