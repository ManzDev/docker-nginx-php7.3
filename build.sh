# Vars
AUTHOR=manz
NAME=php7.3
TAG=1.0
PORT=8080
OS=$(uname)

# Check cross platform
if [ $OS = "Linux" ]
then
  SITE=$(pwd)
else
  SITE=$(pwd -W)
fi

# Build docker image and run container
docker build -t $AUTHOR/$NAME:$TAG .
docker run -it --rm -p $PORT:80 -v $SITE/site:/var/www/html $AUTHOR/$NAME:$TAG
