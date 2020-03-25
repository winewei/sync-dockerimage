#!/bin/bash

ALI_REGISTRY=registry.cn-hongkong.aliyuncs.com/sync-dockerimage/coredns

#config the following env at travis-ui
docker login registry.cn-hongkong.aliyuncs.com -u $DOCKER_USER -p $DOCKER_PASSWORD

for image in $(cat img-list.txt)
do
	imagename=$(echo $image | awk -F '/' '{print $NF}')
	docker pull $image
	docker tag $image $ALI_REGISTRY/$imagename
	# push到阿里云仓库
	docker push $ALI_REGISTRY/$imagename
done
