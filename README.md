# SearxNG

SearXNG is a free internet metasearch engine which aggregates results from more than 70 search services. Users are neither tracked nor profiled. Additionally, SearXNG can be used over Tor for online anonymity.

wikipedia.org/wiki/SearXNG

<img src="https://upload.wikimedia.org/wikipedia/en/thumb/a/a3/SearXNG_logo.svg/1280px-SearXNG_logo.svg.png" width="30%" height="auto" alt="SearxNG logo">

## How to use this Makejail

```console
$ mkdir -p /var/appjail-volumes/searxng/cache
$ mkdir -p /var/appjail-volumes/searxng/config
$ appjail oci run -Pd \
    -o overwrite=force \
    -o virtualnet=":<random> default" \
    -o nat \
    -o fstab="/var/appjail-volumes/searxng/cache /var/cache/searxng" \
    -o fstab="/var/appjail-volumes/searxng/config /usr/local/etc/searxng" \
    ghcr.io/appjail-makejails/searxng searxng
```

The following environment variables can be configured:

* `$SEARXNG_*`: Controls the SearXNG configuration options, look out for environment `$SEARXNG_*` in [server:](https://docs.searxng.org/admin/settings/settings_server.html#settings-server) and [general:](https://docs.searxng.org/admin/settings/settings_general.html#settings-general).
* `$GRANIAN_*`: Controls the [Granian server options](https://docs.searxng.org/admin/installation-granian.html#granian-configuration).

### Arguments (stage: build)

* `searxng_from` (default: `ghcr.io/appjail-makejails/searxng`): Location of OCI image. See also [OCI Configuration](#oci-configuration).
* `searxng_tag` (default: `latest`): OCI image tag. See also [OCI Configuration](#oci-configuration).

### Environment (OCI image)

* `PGID` (default: `1000`): Equivalent to `PUID` but for the Process Group ID.
* `PUID` (default: `1000`): Process User ID for the container's main process, allowing you to match the owner of files written to mounted host volumes to your host system's user. Writable volumes are changed based on this environment variable.

## OCI Configuration

```yaml
build:
  variants:
    - tag: 15.1
      containerfile: Containerfile
      aliases: ["latest"]
      default: true
      args:
        FREEBSD_RELEASE: "15.1"
        PYVER: "312"
        NO_PKGCLEAN: "1"
      cache_dirs: ["pkgcache0:/var/cache/pkg"]
```
