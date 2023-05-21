# build image
docker build -t backup .

# run image with bash to not quit immediately
docker container run --name backup -it -p 445:445 backup bash -rm

