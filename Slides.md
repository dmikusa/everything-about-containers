---
title       : Everything You Wanted to Know About Containers but were Afraid to Ask
author      : Daniel Mikusa
description : An indepth look at all things containers.
keywords    : containers, docker, oci
marp        : true
theme       : jobs
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
-->
![bg left:40%](./img/nikko-osaka-WzZjyThDoR8-unsplash.jpg)

# Everything You Wanted to Know About Containers but were Afraid to Ask

---

<div class="columns">
<div class="column">

## Daniel Mikusa [<small>dan@mikusa.com</small>]
- Lead Software Engineer @ 7SIGNAL, Inc
- Paketo Steering Committee Member
- Cloud-Native Buildpacks Maintainer

</div>
<div class="column center-img">

![drop-shadow width:10em](https://www.7signal.com/hubfs/7SIGNAL-brand-guidelines-logo.png)
![drop-shadow width:10em](https://paketo.io/v2/images/logo-paketo-dark.svg)
![drop-shadow width:10em](https://buildpacks.io/images/buildpacks-logo.svg)

</div>
</div>

---

# Why are we here today?

<!-- 
kdjfkdj adsfadsf asdfasdf
-->

---

# Containers

<div class="only-img">

![drop-shadow height:12em](./img/they-re-everywhere.jpg)

</div>

---

<!--
_footer: 'Photo by <a href="https://unsplash.com/@syhussaini?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Syed Hussaini</a> on <a href="https://unsplash.com/photos/orange-blue-and-green-plastic-containers-F2JwUVuRz2I?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>'
-->

# What is a container?

<div class="only-img">

![drop-shadow height:12em](./img/syed-hussaini-F2JwUVuRz2I-unsplash.jpg)

</div>

---

# What's **NOT** a container?

<div class="only-img">

![drop-shadow height:12em](./img/docker-mark-blue-x.png)

</div>

---

# What's **NOT** a container?

<div class="only-img">

![drop-shadow height:12em](./img/vm-xx.jpg)

</div>

---

# So What is a container then?

- Linux Kernel CGroups
- Linux Kernel Namespaces
- App Armor / capabilities restrictions
- Union FS or Overlay FS
- Base Image
- Configuration

---

