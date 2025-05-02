# Registry Demo

## Docker Hub

Docker Hub has it's own API for fetching things. This is API allows you to fetch data, like what you'd see on the website. Organizations, users, repos, tags. It's not for fetching the actual images though.

You can use the `dh-*.sh` scripts here to fetch data from the Docker Hub APIs. This is specific to Docker Hub though.

## OCI Registry API

What's better is to use the OCI Distribution Spec APIs (i.e. standard OCI Registry APIs).

To fetch actual images, you want this API. There is some overlap with the Docker Hub API, but this API will allow you to actuall fetch images.

1. Fetch a token, run `set -x TOKEN (./oci-fetch-api-key.sh dmikusa library/ubuntu)`.

   **If using a local registry, it's probably not using authentication, so you probably don't need to run this command. You can just `set -x TOKEN ''`.**

2. List tags, run `./oci-list-tags.sh library/ubuntu | jq .`. You should see jammy & noble.

3. Fetch a manifest for an image, run `./oci-fetch-manifest.sh library/ubuntu jammy`. This might return a manifest index (list of manifest) or it might return a single manifest. It depends on the repo/tag entered.

4. If you get a repo list, you can fetch a specific manifest by entering the digest instead of the tag name, run `./oci-fetch-manifest.sh library/ubuntu sha256:b471c68040bbe418a64e33b1353c0404b8a27cdf21d5b5a84a0a48659e055b52`.

5. From here, you have the manifest so you can choose what to do next.
   1. Pull the configuration, run `./oci-fetch-config.sh library/ubuntu sha256:ac8fd8f9416ae816b1ae151b4958449876014a9502f2d8d42dc0268e569c2707`
   2. Pull one or more layers, run `./oci-fetch-layer.sh library/ubuntu sha256:4e243dbf3d7e76afa075ed871906b2ada05fe2b8fdf244d349ead2e46f8b1c53`

Replace `library/ubuntu` with your choice of repo/tag and replace hashes with the actual hashes for the image in question.

Some more details at:

- [https://tech.michaelaltfield.net/2024/09/03/container-download-curl-wget/]()
- [https://github.com/opencontainers/distribution-spec/blob/main/spec.md#endpoints]()
