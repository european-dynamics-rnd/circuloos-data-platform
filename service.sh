#!/bin/bash
#
#  Command Line Interface to start all services associated with the Tutorial
#  For this tutorial the commands are merely a convenience script to run docker-compose
#

set -e
export $(cat .env | grep "#" -v)
command="$1"

FINAL_DOCKER_YML="-f docker-compose.yml -f keycloak.yml -f temporal.yml"  #   -f monitoring.yml

CIRCULOOS_YML=" -f circuloos_custom_apps.yml"
FINAL_DOCKER_YML="$FINAL_DOCKER_YML $CIRCULOOS_YML"

dockerCmd="docker compose"


if (( $# < 1 )); then
	echo "Illegal number of parameters"
	echo "usage: services [start|stop]"
	exit 1
fi

echo "Docker compose configuration" $FINAL_DOCKER_YML

stoppingContainers () {
	CONTAINERS=$(docker ps -aq)
	if [[ -n $CONTAINERS ]]; then 
		echo "Stopping containers"
		# docker rm -f $CONTAINERS
		${dockerCmd}  $FINAL_DOCKER_YML -p $COMPOSE_PROJECT_NAME --env-file .env --env-file .env.secrets down --remove-orphans
	fi
	# VOLUMES=$(docker volume ls -qf dangling=true) 
	# if [[ -n $VOLUMES ]]; then 
	# 	echo "Removing old volumes"
	# 	docker volume rm $VOLUMES
	# fi

}

stoppingContainersAndRemoveVolumes () {
	CONTAINERS=$(docker ps -aq)
	if [[ -n $CONTAINERS ]]; then 
		echo "Stopping containers"
		# docker rm -f $CONTAINERS
		${dockerCmd}  $FINAL_DOCKER_YML -p $COMPOSE_PROJECT_NAME --env-file .env --env-file .env.secrets down --remove-orphans --volumes
	fi

}

command="$1"
case "${command}" in
	"start")
		export $(cat .env | grep "#" -v)
		# stoppingContainers
		echo -e "Starting containers"
		echo ""
        ${dockerCmd} $FINAL_DOCKER_YML -p $COMPOSE_PROJECT_NAME --env-file .env --env-file .env.secrets up -d --remove-orphans # --renew-anon-volumes
		;;
	"stop")
		export $(cat .env | grep "#" -v)
		stoppingContainers
		;;
	"restart")
		echo -e "Restarting containers"
		export $(cat .env | grep "#" -v)
		${dockerCmd} restart
		;;
	"stopAll")
		export $(cat .env | grep "#" -v)
		stoppingContainersAndRemoveVolumes
		;;
esac