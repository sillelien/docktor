# Docktor

A sidecar container to take action when it's companion(s) fail(s).

## Introduction

The Docktor checks every `CHECK_INTERVAL` (default 60) seconds whether the containers it links to are still active.

The linked containers have the environmental variables set on them: `CHECK_COMMAND` and `FIX_COMMAND`. `CHECK_COMMAND` will be past to a Bash shell for evaluation, if it exits with zero (success) then nothing happens, if it exits with non-zero (fail) then `FIX_COMMAND` is executed to try and fix the problem. Usually this will be just to restart a container etc.

An example tutum.yaml is shown below and can be deployedby the button after it.

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


