# Registry Setup

This runs a registry locally. It can be used if you want to run the demos offline. Otherwise, skip this.

## Steps

1. `podman compose -f ./compose-registry.yml up -d`

2. Create this config file so `skopeo` treats the registry as http, not https.
   
   ```
   $ cat ~/.config/containers/registries.conf
   [[registry]]
   location="localhost:5001"
   insecure=true
   ```

3. Load some images into the registry. This uses [skopeo](https://github.com/containers/skopeo).
   1. `skopeo copy --multi-arch all docker://library/ubuntu:jammy docker://localhost:5001/library/ubuntu:jammy`
   2. `skopeo copy --multi-arch all docker://library/ubuntu:noble docker://localhost:5001/library/ubuntu:noble`

4. Go to `http://localhost:8070/` and see the images loaded.

That's it.