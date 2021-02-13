IMAGE=${IMAGE:=oveits/curl-envsubst-jq-yq-kubectl:ubuntu-slim}

docker login \
  && docker build -t ${IMAGE} . \
  && docker push ${IMAGE}