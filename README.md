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
    -o expose=8080 \
    -o fstab="/var/appjail-volumes/searxng/cache /var/cache/searxng" \
    -o fstab="/var/appjail-volumes/searxng/config /usr/local/etc/searxng" \
    ghcr.io/appjail-makejails/searxng searxng
...
$ appjail jail list -j searxng name network_ip4
NAME     NETWORK_IP4
searxng  10.0.0.8
```

Then you can hit `http://10.0.0.8:8080` (or `http://searxng:8080` if you've configured [DNS in AppJail](https://appjail.readthedocs.io/en/latest/networking/DNS/)) or `http://host-ip:8080` in your browser (and from an external host).

The following environment variables can be configured:

* `$SEARXNG_*`: Controls the SearXNG configuration options, look out for environment `$SEARXNG_*` in [server:](https://docs.searxng.org/admin/settings/settings_server.html#settings-server) and [general:](https://docs.searxng.org/admin/settings/settings_general.html#settings-general).
* `$GRANIAN_*`: Controls the [Granian server options](https://docs.searxng.org/admin/installation-granian.html#granian-configuration).

### Arguments (stage: build)

* `searxng_from` (default: `ghcr.io/appjail-makejails/searxng`): Location of OCI image. See also [OCI Configuration](#oci-configuration).
* `searxng_tag` (default: `latest`): OCI image tag. See also [OCI Configuration](#oci-configuration).

### Environment (OCI image)

* `PGID` (default: `1000`): Equivalent to `PUID` but for the Process Group ID.
* `PUID` (default: `1000`): Process User ID for the container's main process, allowing you to match the owner of files written to mounted host volumes to your host system's user. Writable volumes are changed based on this environment variable.

### Volumes

| Name | Owner | Group | Perm | Type | Mountpoint |
| --- | --- | --- | --- | --- | --- |
| appjail-76ed6cdd7a-usr_local_etc_searxng | `${PUID}` | `${PGID}` | - | - | /usr/local/etc/searxng |
| appjail-bc3a28353e-var_cache_searxng | `${PUID}` | `${PGID}` | - | - | /var/cache/searxng |

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
