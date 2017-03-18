nuvola-overlay
=================

This repository contains ebuilds and associated files for
building nuvola on Gentoo.  It is a work-in-progress so,
no guarantees... seriously, none!  It probably won't work yet.


To add this overlay to a Gentoo system, install layman
and run the following command as root:

```bash
wget https://raw.github.com/gmt/nuvola-overlay/master/nuvola.xml -O /etc/layman/overlays/nuvola.xml
layman -a nuvola
```

You will want to configure the nuvola plugins via some mechanism,
which is funny because I haven't yet provided any way to do this.

-gmt 

Greg Turner <gmt@be-evil.net>
