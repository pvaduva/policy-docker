#!/bin/bash

REGISTRY='onapmulti'
IMAGE_NAME=$1 
IMAGE_TAG=$2
HOST_ARCH='amd64'
if [ "$(uname -m)" == 'aarch64' ]
then
    HOST_ARCH='arm64'
fi
MT_RELEASE='v0.9.0'

#create the template to be used with the manifest list
cat > manifest_template.yaml <<EOF
image: ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}
manifests:
  -
    image: ${REGISTRY}/${IMAGE_NAME}-amd64:${IMAGE_TAG}
    platform:
      architecture: amd64
      os: linux
  -
    image: ${REGISTRY}/${IMAGE_NAME}-aarch64:${IMAGE_TAG}
    platform:
      architecture: arm64
      os: linux
EOF

wget https://github.com/estesp/manifest-tool/releases/download/${MT_RELEASE}/manifest-tool-linux-${HOST_ARCH} -O ./manifest-tool
chmod u+x manifest-tool
./manifest-tool push from-spec manifest_template.yaml
