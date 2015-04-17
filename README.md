Look at the relevant branches.

Since it's not pushed on Docker, it needs to be built:

```
$ cd drupal-docker
$ docker build -t guguss/dX .
```

Then it's available as a local Docker image:

```
$ docker images
REPOSITORY                        TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
guguss/d8                         latest              5ed9943bde52        50 minutes ago      590.6 MB
```

And can be used easily to kickstart Docker containers:

```
$ docker-compose -f path-to-docker-compose/docker-compose.yml up -d
Recreating repository_db_1...
Recreating repository_web_1...
```
