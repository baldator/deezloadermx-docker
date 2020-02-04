# deezloadermx-docker

Deezloader Remix in a Docker container.

## How to run this

Deezloader Remix will work out of the box, but you should at least set a fixed port for the web interface and mount a folder to the container for where your downloads will go.

You can also map a folder on the host for the config file (mount a local folder to /config/), but that's optional. If they add or rework settings in the future, there is no guarantee that your old configs will work, so beware.

### Example for Docker:
```
$ docker run -d --name Deezldr \
              -v /your/storage/path/:/downloads \
              -v /your/config/location:/config \
              -e PUID=1000 \
              -e PGID=1000 \
              -p 1730:1730 \
              baldator/deezloaderrmx
```

### Example for Docker Compose:
```
version: '3.3'
services:
    deezloaderrmx:
	    image: baldator/deezloaderrmx
        container_name: Deezldr
        volumes:
            - /your/storage/path/:/downloads
            - /your/config/location:/config
        environment:
            - PUID=1000
            - PGID=1000
        ports:
            - 1730:1730
```

### Explanation:

`-v /your/storage/path/:/downloads`     - Path for your music downloads.

`-v /your/config/location:/config`      - OPTIONAL: Path to your local configuration.

`-e PUID=1000`                          - OPTIONAL: User ID of the user you want the container to run as in order to fix folder permission issues.

`-e PGID=1000`                          - OPTIONAL: Group ID, see above.

`-p 1730:1730`                          - Port opened for the web interface. (port `1731` if you are using the `dev` tag)

`bocki/deezloaderrmx`                   - This container.

To access the web interface, go to http://YOURSERVERIP:1730 

## Disclaimer and Links

I am in no way affiliated with the DeezloaderRMX project.

Dockerhub link for this container: https://hub.docker.com/r/baldator/deezloaderrmx

Repo for Deezloader Remix: https://notabug.org/RemixDevs/DeezloaderRemix

Issue Tracker for this Docker: https://github.com/baldator/deezloadermx-docker/issues


Feel free to open an issue that is Docker related, and not related to Deezloader development. Go to the Deezloader repository for that.
