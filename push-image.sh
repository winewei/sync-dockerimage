#!/bin/bash

# hongkong region
ALI_REGISTRY=registry.cn-hongkong.aliyuncs.com/sync-dockerimage

#config the following env at travis-ui
docker login registry.cn-hongkong.aliyuncs.com -u $DOCKER_USER -p $DOCKER_PASSWORD

for image in $(cat img-list.txt | grep -v '^#')
do
	imagename=$(echo $image | grep -v '^#' | awk -F '/' '{print $NF}')
	docker pull $image
	docker tag $image $ALI_REGISTRY/$imagename
	# push到阿里云仓库
	docker push $ALI_REGISTRY/$imagename
done

## shenzhen region
#ALI_REGISTRY=registry.cn-shenzhen.aliyuncs.com/sync-dockerimage
#
##config the following env at travis-ui
#docker login registry.cn-shenzhen.aliyuncs.com -u $DOCKER_USER -p $DOCKER_PASSWORD
#
#for image in $(cat img-list.txt | grep -v '^#')
#do
#	imagename=$(echo $image | grep -v '^#' | awk -F '/' '{print $NF}')
#	docker pull $image
#	docker tag $image $ALI_REGISTRY/$imagename
#	# push到阿里云仓库
#	docker push $ALI_REGISTRY/$imagename
#done
