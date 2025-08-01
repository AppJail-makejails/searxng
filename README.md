# SearXNG

SearXNG is a free internet metasearch engine which aggregates results from more than 70 search services. Users are neither tracked nor profiled. Additionally, SearXNG can be used over Tor for online anonymity.

docs.searxng.org

![searxng logo](https://upload.wikimedia.org/wikipedia/en/thumb/a/a3/SearXNG_logo.svg/2560px-SearXNG_logo.svg.png)

## How to use this Makejail

### Standalone

```sh
appjail makejail \
    -j searxng \
    -f gh+AppJail-makejails/searxng \
    -o virtualnet=":<random> default" \
    -o nat
```

### Deploy using appjail-director

**appjail-director.yml**:

```yaml
options:
  - virtualnet: ':<random> default'
  - nat:

services:
  metasearch:
    name: searxng
    makejail: gh+AppJail-makejails/searxng
    options:
      - expose: '8888'
    environment:
      - SEARXNG_SECRET: 'mysupersecret123'
      - SEARXNG_REDIS_URL: 'redis://searxng-redis:6379/0'
  cache:
    name: searxng-redis
    makejail: gh+AppJail-makejails/redis
```

**.env**:

```
DIRECTOR_PROJECT=searxng
```

### Arguments:

* `searxng_tag` (default: `13.5`): See [#tags](#tags).
* `searxng_ajspec` (default: `gh+AppJail-makejails/searxng`): Entry point where the `appjail-ajspec(5)` file is located.
* `searxng_conf` (default: `files/searxng.yml`): Configuration file.

### Environment:

* `SEARXNG_DEBUG` (optional): Allow a more detailed log if you run SearXNG directly. Display detailed error messages in the browser too, so this must be deactivated in production.
* `SEARXNG_PORT` (optional): Specifies the source port SearxNG should use.
* `SEARXNG_BIND_ADDRESS` (optional): Bind address of the SearXNG web application.
* `SEARXNG_SECRET` (optional): Used for cryptography purpose.
* `SEARXNG_BASE_URL` (optional): The base URL where SearXNG is deployed. Used to create correct inbound links.
* `SEARXNG_REDIS_URL` (optional): URL to connect redis database.

## Tag

| Tag    | Arch    | Version        | Type   |
| ------ | ------- | -------------- | ------ |
| `13.5` | `amd64` | `13.5-RELEASE` | `thin` |
| `14.3` | `amd64` | `14.3-RELEASE` | `thin` |
