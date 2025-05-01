---
title       : Everything You Wanted to Know About Containers but were Afraid to Ask
author      : Daniel Mikusa
description : An indepth look at all things containers.
keywords    : containers, docker, oci
marp        : true
theme       : jobs
paginate    : true
---

<style>
.columns {
    display: flex;
}
.column {
    flex: 1;
}
.center-img img {
    display: block;
    margin-left: auto;
    margin-right: auto;
}
.only-img img {
    margin-top: 1.5em;
    display: block;
    margin-left: auto;
    margin-right: auto;
}
</style>

<!-- 
_class: titlepage
_footer: Photo by <a href="https://unsplash.com/@nosaka?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">nikko osaka</a> on <a href="https://unsplash.com/photos/brown-and-red-shipping-containers-WzZjyThDoR8?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
_paginate: false
-->
![bg left:40%](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/nikko-osaka-WzZjyThDoR8-unsplash.jpg)

# Everything You Wanted to Know About Containers but were Afraid to Ask

<!-- 
Welcome! This is my session. Let's get started!
-->

---

<div class="columns">
<div class="column">

## Daniel Mikusa
- Lead Software Engineer @ 7SIGNAL, Inc
- Paketo Steering Committee Member
- Cloud-Native Buildpacks Maintainer

### Contact Me
- <small>dan@mikusa.com</small>
- <small>https://github.com/dmikusa</small>
- <small>https://www.mikusa.com</small>

</div>
<div class="column center-img">

![drop-shadow width:10em](https://www.7signal.com/hubfs/7SIGNAL-brand-guidelines-logo.png)
![drop-shadow width:10em](https://paketo.io/v2/images/logo-paketo-dark.svg)
![drop-shadow width:10em](https://buildpacks.io/images/buildpacks-logo.svg)

</div>
</div>

<!--
Who am I? I work at 7SIGNAL, a leader in WiFi optimization. In a nutshell, we write software that helps you to make your WiFi rock.

I also help with a couple of OSS projects, Cloud-Native Buildpacks and Paketo Buildpacks. Both, great tools for building your container images.

While I'm not covering WiFi or buildpacks in this talk, if you're curious feel free to come chat after the session.
-->

---

# Slides

<div class="center-img">

![drop-shadow height:12em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/qr-code.png)

</div>
<div style="text-align: center; padding-top: 0.5em;">

[https://github.com/dmikusa/everything-about-containers]()

</div>

<!--
Slides are available at the link above.
-->

---

# Why are we here today?

<!--
To talk about containers!

Poll:
- Who's using containers?
- Who's doing the bare minimum to get containers into prod?
- Who's a container expert?

It's common. Many devs use containers to get a job done, but don't really understand them. It's easy enough to copy & paste, get the job done, and move on. Especially when you're busy writing code.

Today's a chance to fix that.
-->

---

# Learn & Understand Containers

<div class="only-img">

![drop-shadow height:12em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/flair.jpg)

</div>

<!-- 
You can get by with the minimum amount of container flair, but there are benefits to understanding the technology better.

- You can understand and evaluate other container related technology easier and faster. So many things are built using containers, understanding this building block gives you a leg up.

- You can design systems that work better and take advantage of the technology. For example, containers can be used to streamline build pipelines, more efficiently distribute your applications, and reduce vendor lock-in.

- It's a building block, so after you understand it, you can use the technology in new and interesting ways.
-->

---

# Also, because ...

<div class="only-img">

![drop-shadow height:12em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/they-re-everywhere.jpg)

</div>

<!--
If for no other reason, they're everywhere. It helps to understand the technology, because there's a good chance you'll see it again.
-->

---

<!--
_footer: 'Photo by <a href="https://unsplash.com/@syhussaini?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Syed Hussaini</a> on <a href="https://unsplash.com/photos/orange-blue-and-green-plastic-containers-F2JwUVuRz2I?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>'
-->

# What is a container?

<div class="only-img">

![drop-shadow height:12em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/syed-hussaini-F2JwUVuRz2I-unsplash.jpg)

</div>

<!--
It's complicated, but at a high level, a "container" refers to an isolated process on a Linux system, but it's a little easier to describe what it's *not*.
-->

---

# What's **NOT** a container?

<div class="only-img">

![drop-shadow height:12em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/docker-mark-blue-x.png)

</div>

<!--
It's not Docker. It's not a Dockerfile. This is a very common misconception and incorrect use of terminology. Docker is a popular tool to use containers, it will let you create and run containers, but it is not itself a container.
-->

---

# What's **NOT** a container?

<div class="only-img">

![drop-shadow height:12em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/vm-xx.jpg)

<!--
It's not a VM. 

Containers are similar to VMs and it's a natural way to think about what a container is doing for you, because they both provide isolation. There are differences though. 

VMs offer a higher level of isolation, isolating and running an entire OS, while containers share a kernel because they isolate at the process level. We'll talk more about the differences on an upcoming slide.
-->

</div>

---

# So What is a container then?

## TL;DR - It's an isolated process.

<!--
That's it. It's a normal process running on your system, but the kernel is enforcing some additional isolation and restrictions on that process. In a way so that the process doesn't know it's being restricted or isolated.
-->

---

# Container Strengths & Weaknesses

<div class="columns">
<div class="column">

## Strengths

- Cheap/Fast
- Easy way to package code
- Ubiquitous & battle tested
- Strong tooling & libraries
- Standardized (OCI)
- Efficient distribution protocol

</div>
<div class="column center-img">

## Weaknesses

- Weaker isolation
- Container security config [*](https://security.stackexchange.com/a/153016)
- CPU shares are challenging
- Noisy neighbors

</div>
</div>

<!-- 
Classic use cases where containers are a good fit:

- You want a throw-away environment. Try something out in a container, delete when you're done. Very easy to clean up.
  
- You need a different distro. Want to run 3rd party software that requires RedHat, but like to run Debian. Run that in a container with a RedHat image, done.

- You need to isolate or sandbox some code and you need it to start up really fast and have low overhead. Containers are a great fit.

- You need to distribute your app and ensure it runs consistently everywhere. Container images are great for that.

- You want to run some Linux based software on MacOS or Windows. A container can be a great way to do that.

- Got some web services, a web site, a 12-factor app, all those are great deployed in containers.

Some examples where containers are not always the best fit:

- Desktop apps. It's hard to bundle a UI.
- CLI apps. It can work, but it's often hard to make sure the CLI has access to everything it needs. At least in the typical isolation used with Docker/Podman.
- Software that requires strong guarantees around hardware resource availability (very latency specific, almost real-time requirements). That's probably a case for dedicated hardware. Both container and VMs can suffer from noisy neighbor problem.
- Software that requires access to specific hardware like GPU. Sure you can run that LLM in a container, but it requires a lot of work to ensure it has access to your GPU.

There are also a couple of examples where they're not really good or bad, but are important to consider.

1. Security is good, but different from VMs. VMs start with high isolation which gives them a more secure by default position. Containers are just isolated processes, but you have to layer on that isolation and you have to take away capabilities. If this is done wrong, if you don't configure things correctly, there can be problems.

2. State. Never put state into your containers. This makes them impossible to upgrade, because you upgrade containers by throwing them away and making a new one using the latest version of the software. That's OK though, you just need to provide some external storage for the container to use. VMs are different. You typically run them as if they are hardware, they can contain state, and you upgrade them in-place.
-->

---

# What else do we need?

<div class="only-img">

![drop-shadow height:12em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/image.png)

</div>

<!--
Images! We need a container image. So...
-->

---

# What's a container image?

<style scoped>
.top-pad {
    margin-top: 2em;
}
.plus {
    margin-top: 5.5em;
    margin-left: -1.5em;
}
</style>

<div class="columns">
<div class="column center-img top-pad">

![drop-shadow height:12em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/files.webp)

</div>
<div class="column center-img plus">

![drop-shadow height:5em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/plus.webp)

</div>
<div class="column center-img top-pad">

![drop-shadow height:12em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/config.png)

</div>

<!--
It's pretty simple. An image is a collection of files plus some configuration. But it has some very special properties...
-->

---

# Layers

<div class="only-img">

![drop-shadow height:12em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/layers.png)

</div>

<!--
An image is made up of one or more layers, each with it's own unique set of files. Layers are applied in order, with layers on top shadowing or masking files in the layers below them.

A containerized process sees this as a single filesystem though, like all the layers have been flattend. It's like if you were plaing tetris but looking down from the top. Blocks go in, but you can only see the top most blocks.
-->

---

# Sharing Layers

<div class="only-img" style="padding-top: 1em">

![drop-shadow height:10em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/shared-layers.png)

</div>

<!--
What's particularly great about layers is that they can be shared! Layers are independent and you can compose them together to build other images.

Like if you have Ubuntu or UBI image, that can provide the base layer for your images. You can then add different layers on top of that. Like maybe one for each of your applications.

When users pull or fetch your images, the base layer only gets downloaded once but it can be paired with the layer for each app to run those apps.

Even cooler, you may not even need to fetch that base image at all. It's possible someone else running a container on container orchestrator of choise has already done the same thing and the system can just reuse without fetching it again.

The same goes for pushing or publishing images. Your software doesn't have to republish layers that already have been published.

This trick work great with the cloud providers. Using the cloud provider images, like AWS's base Lambda images, can reduce the load time for your Lambdas because that base is guaranteed to be cached already.

A word of warning about composing image layers. Overlapping files in different image layers can cause problems. Let's say your base layer keeps an up-to-date OpenSSL, but a layer above that does not and has an old, vulnerable one. Well, you're getting the old, vulnerable OpenSSl because it's in a higher layer. 

Image scanners can help with this, so can tools like `dive` that let you dig through the layers. As we'll see in the first demo, you can dig through those layers yourself too.
-->

---

# Image Hashes

<div class="only-img" style="padding-top: 1em">

![drop-shadow height:10em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/shared-layers-hashes.png)

<div style="text-align: right">sha256:32acffd</div>
</div>

<!--
Ok, so how does this work? How can we safely reuse container layers?

Every layer has a hash. The hash guarantees the contents of the layer, so you know what's in it and that it can't be changed or tampered with. This is why it's safe.

It also allows deduplication of layers, which is how different images can share layers. The tooling can uniquely identify a layer independent of the image and know exactly what's in that layer.

The configuration for the image also has a hash and so does the image as a whole. This provides the same change guarnatees for configuration of the image and the image as a whole.
-->

---

# Volume Mounts

<style scoped>
.top-pad {
    margin-top: 2em;
}
.plus {
    margin-left: -1.5em;
}
</style>

<div class="columns">
<div class="column center-img top-pad">

![drop-shadow height:12em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/files.webp)

</div>
<div class="column center-img plus">

![height:5em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/curved-arrow.jpg)

</div>
<div class="column center-img top-pad">

![drop-shadow height:12em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/volume-icon.png)

</div>

<!--
In addition to layers, the person running your container image can mount additional volumes at any location they choose into the image. Like a layer, this overwrites what is at that location in the image.

For example, you can mount a directory with an Nginx configuration in it, to the `/etc/nginx/` directory of an Nginx image. This overwrites the default configuration, providing a nice way for users of your image to configure services bundled in the image.

This does need to be done carefully. You can override files in the container and easily break stuff, or like the OpenSSL issue I mentioned, inject vulnerable software. Also, be aware that not every container orchestrator allows you to do this. AWS ECS for example, technically does, but it's a real pain to use.
-->

---

# Demo: Deconstructing a Container Image

---

# Image Distribution

<div class="only-img" style="padding-top: 1em">

![drop-shadow height:10em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/registry.png)

</div>

<!--
Now we know what an image is, how do we get one?

Images are distributed through container registries. You can "push" a container image to a registry and "pull" images from a container registry.

There are public container registries like Docker Hub, GHCR, or Quay.io. The cloud providers all have their own registries, and you can also run your own registry too.

While it sounds fancy, a "container registry" is just an HTTP service. There's a defined API that's part of the OCI distribution specification. While you typically hear about "push" and "pull" operations, there is no single API call to do that. Those high-level operations are made up of multiple API calls. This allows the client to efficiently interact with the registry.

[https://github.com/opencontainers/distribution-spec]

While it's convenient to use tools like Docker, Podman or skopeo to interact with those APIs, you can also use `curl` or your programming library of choice and fetch images that way too. Let's take a look at doing that.
-->

---

# Demo: Fetching Images

---

# Running Containers

![bg right:55%](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/wes-tindel-XtVl8IL-8EI-unsplash.jpg)

<!--
Now that we have all the pieces, the next step is to run a container.

First, let me introduce a new term. Container orchestrator. I've used it a couple times now, and it is just a fancy way of say "some system that runs container".

There are many tools that can run a container. That's part of the beauty of containers. They are a standard, so you have all sorts of different software that can take your container images and run them.

Running locally, you can use Docker or Podman. Running as a service, you have Kubernetes, Cloud Providers (AWS ECS, Lambda or App Runner), and all sorts of PaaS & IaaS technologies.

What is actually happening here when your container is run though?
-->

---

# What's Used to Run a Container

<div class="only-img" style="padding-top: 1em">

![drop-shadow height:10em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/linux-kernel.jpg)

</div>

<!--
First, we need the Linux kernel. It is the core requirement to run containers.

You might be thinking, well I can run containers on my MacOS or Windows machine and you're right, but they're not running on your machine directly. On non-Linux operating systems like Windows and MacOS, your containers are running in a Linux VM. Windows technically has some native support to run Windows in a container, but if you're running Linux containers they're running in a Linux VM).
-->

---

# Linux Kernel Primitives

- CGroups
- Namespaces
- Capabilities
- Seccomp
- AppArmor

<!--
What is the Linux Kernel giving us?

The Linux kernel provides the primitives to isolate a process, remember a container is just an isolated process.

It gives us Cgroups, which are a way to put limits on the process around things like memory & CPU usage, and it gives us namespaces, which provide a variety of different dimensions (network, process ids, mounts, IPC, user, and unix time sharing) in which we can isolate a process.

The cool thing about namespaces is that you don't necessarily have to use all of them. Most container orchestrators do, because they want more isolation and security, but you can do things like have a shared network between containers (ex: K8s pods) or have a shared filesystem or process space between containers.

This is also a good point to address the fact that you can run multiple processes in a container (ex: `docker exec`). So how is that possible, when a container is just an isolated process? Well, namespaces are how that happens. Your container orchestractor can launch a second process, and put it into the same namespaces, effectively allowing the processes to see the same files, use the same network, and generally look like it's running in the same logical container.

Beyond cgroups and namespaces, the kernel also gives us the ability to drop certain permissions, called capabilities, such as `CAP_SYS_ADMIN`, which limit what the container can do and thus increase the security posture of the container. 

In addition to dropping capabilities, many tools will also use `seccomp`, which can be used to filter what syscalls are allowed by the process.

Lastly, AppArmor allows further allow/block-listing of what the process can do. In this case, it can restrict access to the files or network at a fine grained level.

In a nutshell, these all allow a container (i.e. isolated process) to be sandboxed.

[https://security.stackexchange.com/questions/196881/docker-when-to-use-apparmor-vs-seccomp-vs-cap-drop]
-->

---

# A Filesystem

<div class="only-img" style="padding-top: 1em">

![drop-shadow height:12em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/files.webp)

</div>

<!--
Ok, so we've got our kernel. The next thing we need is a filesystem for the container. This can range from nothing, up to GB's of files. It all depends on what the process needs to operate.

The files for your container come from a container image. You supply the container image to your container orchestrator, it extracts the layers and using a union or overlay filesystem, presents them a single set of files to the container. We do this by using the `pivot_root` syscall to swap out the host filesystem for our new filesystem.

In addition to the image files, this is also your chance to volume mount in any external files or directories. As I mentioned previously, storing files in your container image is bad. This is how you get around that. You can volume mount in external storage that will persist beyond the lifetime of your container.
-->

---

# Configuration / Settings

<div class="only-img" style="padding-top: 1em">

![drop-shadow height:12em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/config.png)

</div>

<!--
The last thing you will need is configuration. The command to run, working directory, maybe some environment variables, possibly labels, a health check to run, and maybe other volumes to mount into the container.

These are all things that can change the way the container operates, but don't require rebuilding the container image.
-->

---

# Run Docker Run

- `docker run`
- `podman run`
- `kubectl apply`
- AWS ECS, Lambda (or other Cloud Provider)

<div class="only-img" style="padding-top: 1em">

![bg fit left:40%](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/easy-button.jpg)

</div>

<!--
The easy way to run a container is with Docker, Podman, Kubernetes, or tools from one of the many Cloud Provider.

These tools handle all of the heavy lifting. Fetching images, storing images, creating file systems, creating the container securely, allowing you to configure them and providing you with all the tools to manage your containers & images.
-->

---

# The Hard Way

<div class="only-img">

![drop-shadow height:12em](https://raw.githubusercontent.com/dmikusa/everything-about-containers/refs/heads/main/slides/img/hard-way.webp)

</div>

<!--
These tools are just using Linux Kernel APIs, so one can write code and build their own containers. In most cases, you'd want to use existing tooling (faster/easier/more secure), but it's good to remember that you can do this stuff too! It's achievable and there may come a day when you can take advantage of this in your projects! 

To experiment, the Linux Kernel also provides some tooling that you can use to manipulate these APIs. For example, `unshare` allows you to start processes running with different namespaces. There's also libcgroup, which provides tooling for interacting with Cgroups. Tools like Docker & Podman run also support options for adjusting some of the cgroup & namespace configurations for the containers that they launch.
-->

---

# Demo: namespaces & cgroups

---

<style scoped>
img {
    padding-top: 1.5em;
    height: 300px;
    width: 300px;
}
</style>

# Questions?

<div class="only-img">

:thinking:

</div>
