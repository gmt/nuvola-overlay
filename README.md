nuvola-overlay
=================

This repository contains experimental ebuilds and metadata
for building nuvola on Gentoo.  It is a work-in-progress so,
don't expect much but it's a start.


To add this overlay to a Gentoo system, install layman
and run the following command as root:

```bash
# wget https://raw.github.com/gmt/nuvola-overlay/master/nuvola.xml -O /etc/layman/overlays/nuvola.xml
# layman -a nuvola
```

You will want to configure the nuvola plugins via some mechanism,
which is funny because I haven't yet provided any way to do this.

Well that didn't take long.  After finally getting peek at what nuvola is
capable of, I'm pretty confident it's not the tool I'm looking for.  So I'll
probably abandon this effort.  If you'd like to pick up where I left off, let
me know, I'd happily direct folks to someone else's more serious fork.

Personally, I think I'm done playing with it.

-gmt
