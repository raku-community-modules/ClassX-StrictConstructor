[![Actions Status](https://github.com/raku-community-modules/ClassX-StrictConstructor/actions/workflows/linux.yml/badge.svg)](https://github.com/raku-community-modules/ClassX-StrictConstructor/actions) [![Actions Status](https://github.com/raku-community-modules/ClassX-StrictConstructor/actions/workflows/macos.yml/badge.svg)](https://github.com/raku-community-modules/ClassX-StrictConstructor/actions) [![Actions Status](https://github.com/raku-community-modules/ClassX-StrictConstructor/actions/workflows/windows.yml/badge.svg)](https://github.com/raku-community-modules/ClassX-StrictConstructor/actions)

NAME
====

ClassX::StrictConstructor - Make your object constructors blow up on unknown attributes

SYNOPSIS
========

```raku
use ClassX::StrictConstructor;

class Foo does ClassX::StrictConstructor {
    has $.a;
    has %.b;
}

Foo.new(a => 1, b => {bb => 2, bbb => 3});  # ok

Foo.new(a => 1, b => 2, c => 3);            # dies
```

DESCRIPTION
===========

This is Perl's [MooseX::StrictConstructor](https://metacpan.org/pod/MooseX::StrictConstructor) module ported to Raku as a role.

The test suite is ported as well, except for the parts that don't make sense in Raku anymore.

I had fun writing this. I hope you enjoy using it too.

AUTHOR
======

Tadeusz Sośnierz

COPYRIGHT AND LICENSE
=====================

Copyright 2014 - 2019 Tadeusz Sośnierz

Copyright 2024 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

