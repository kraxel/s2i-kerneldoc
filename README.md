# s2i builder for linux kernel documentation

Source: [https://github.com/kraxel/s2i-kerneldoc](https://github.com/kraxel/s2i-kerneldoc)

Image: kraxel/s2i-kerneldoc @ docker.io registry

## Deploy in openshift

```
oc new-app kraxel/s2i-kerneldoc~git://some.host/path/to/linux/kernel/source/repo.git
```

