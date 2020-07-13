# s2i builder for linux kernel documentation

Source: [https://github.com/kraxel/s2i-kerneldoc](https://github.com/kraxel/s2i-kerneldoc)

Image: kraxel/s2i-kerneldoc @ docker.io registry

## Deploy in openshift

```
oc new-app kraxel/s2i-kerneldoc~git://some.host/path/to/linux/kernel/source/repo.git
```

## Note 1

Meanwhile simply uses the image registry.gitlab.com/kraxel/s2i-sphinx
without anything added, so you can that instead.

## Note 2

Not working right now because latest upstream linux kernel docs don't
build with latest sphinx (kernel 5.8-rc5 & sphinx 3.1).
