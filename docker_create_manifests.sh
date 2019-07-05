#!/bin/bash
TAG=''
case $1 in

  'dublin')
    TAG='dublin'
    ;;
  *)
    TAG='latest' ;;
esac
./policy-base/alpine/docker_manifest.sh policy-base-alpine $TAG
./policy-common/alpine/docker_manifest.sh policy-common-alpine $TAG 
