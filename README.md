# How to build this image

```bash
docker build -t local/bug-telegraf .
```

# Test the error

First build the image.

Then, run it and wait for it to finish. No input data will be gathered:

```bash
$ docker run --rm local/bug-telegraf
2021-04-14T10:00:45Z I! Starting Telegraf 1.18.1
2021-04-14T10:00:45Z D! [agent] Initializing plugins
2021-04-14T10:00:45Z D! [agent] Starting service inputs
2021-04-14T10:00:55Z D! [agent] Stopping service inputs
2021-04-14T10:00:55Z D! [agent] Input channel closed
2021-04-14T10:00:55Z D! [agent] Stopped Successfully
```

If you run it as root the data will be gathered

```bash
$ docker run --rm -u root local/bug-telegraf
2021-04-14T10:01:20Z I! Starting Telegraf 1.18.1
2021-04-14T10:01:20Z D! [agent] Initializing plugins
2021-04-14T10:01:20Z D! [agent] Starting service inputs
2021-04-14T10:01:20Z D! [inputs.tail] Tail added for "/var/log/apache2/error_log"
> example,host=3ad8cb8da05c,path=/var/log/apache2/error_log,result=ok value=1i 1618394480887032445
> example,host=3ad8cb8da05c,path=/var/log/apache2/error_log,result=ok value=2i 1618394480887041009
> example,host=3ad8cb8da05c,path=/var/log/apache2/error_log,result=ok value=3i 1618394480887049527
> example,host=3ad8cb8da05c,path=/var/log/apache2/error_log,result=error value=3i 1618394480887053096
2021-04-14T10:01:30Z D! [agent] Stopping service inputs
2021-04-14T10:01:30Z D! [inputs.tail] Tail removed for "/var/log/apache2/error_log"
2021-04-14T10:01:30Z D! [agent] Input channel closed
2021-04-14T10:01:30Z D! [agent] Stopped Successfully

```

# How to diagnose the container

If you need to drop to a container inside the shell you can:

```bash
# As "telegraf" user
docker run -it --rm --entrypoint bash local/bug-telegraf

# As "root" user
docker run -it --rm --entrypoint bash -u root local/bug-telegraf
```
