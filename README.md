# Docktor

Docktor fixes other containers, it is a sidecar container which take actions when it's companion(s) fail(s).

## Introduction

The Docktor checks every `CHECK_INTERVAL` (default 60) seconds whether the containers it links to are still active.

The linked containers have the environmental variables set on them: `CHECK_COMMAND` and `FIX_COMMAND`. `CHECK_COMMAND` will be passed to a Bash shell for evaluation, if it exits with zero (success) then nothing happens, if it exits with non-zero (fail) then `FIX_COMMAND` is executed to try and fix the problem. Usually this will be just to restart a container etc.

An example tutum.yml is shown below and can be deployed by the button after it.

```yaml
docktor:
  image: vizzbuzz/docktor
  links:
    - test
  roles:
    - global

test:
  image: nginx
  environment:
    CHECK_COMMAND: "curl http://${TEST_PORT_80_TCP_ADDR}:{TEST_PORT_80_TCP_PORT} | grep nginx.com"
    FIX_COMMAND: "/scripts/fixes/tutum_restart.sh ${TEST_TUTUM_API_URL}"
```

[![Deploy to Tutum](https://s.tutum.co/deploy-to-tutum.svg)](https://dashboard.tutum.co/stack/deploy/)

[![Docker Registry](https://img.shields.io/docker/pulls/vizzbuzz/docktor.svg)](https://registry.hub.docker.com/u/vizzbuzz/docktor)

[![GitHub License](https://img.shields.io/github/license/vizzbuzz/docktor.svg)](https://raw.githubusercontent.com/vizzbuzz/docktor/master/LICENSE)

[![GitHub Issues](https://img.shields.io/github/issues/vizzbuzz/docktor.svg)](https://github.com/vizzbuzz/docktor/issues)
    
[![GitHub Release](https://img.shields.io/github/release/vizzbuzz/docktor.svg)](https://github.com/vizzbuzz/docktor)

[![Image Layers](https://badge.imagelayers.io/vizzbuzz/docktor.svg)](https://imagelayers.io/?images=vizzbuzz/docktor:latest 'Get your own badge on imagelayers.io') 


