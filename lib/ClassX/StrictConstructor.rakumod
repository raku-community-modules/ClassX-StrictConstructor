class X::UnknownAttribute is Exception {
    has @.extras;
    has $.typename;

    method message {
        "The following attributes are not declared for type $!typename: {@!extras.join(", ")}"
    }
}

role ClassX::StrictConstructor {
    sub has_attr($type, $attr) {
        for <$! @! %!> -> $prefix {
            CATCH { default { next } }
            $type.^get_attribute_for_usage($prefix ~ $attr);
            return True;
        }
        False
    }

    method new(*%attrs) {
        my @extras;
        for %attrs.keys -> $attr {
            unless has_attr(self.WHAT, $attr) {
                my $inherited = False;
                for self.^parents -> $parent {
                    $inherited = True if has_attr($parent, $attr)
                }
                @extras.push: $attr unless $inherited;
            }
        }
        if @extras {
            die X::UnknownAttribute.new(typename => self.^name, :@extras) 
        }
        nextsame;
    }
}

=begin pod

=head1 NAME

ClassX::StrictConstructor - Make your object constructors blow up on unknown attributes

=head1 SYNOPSIS

=begin code :lang<raku>

use ClassX::StrictConstructor;

class Foo does ClassX::StrictConstructor {
    has $.a;
    has %.b;
}

Foo.new(a => 1, b => {bb => 2, bbb => 3});  # ok

Foo.new(a => 1, b => 2, c => 3);            # dies

=end code

=head1 DESCRIPTION

This is Perl's L<MooseX::StrictConstructor|https://metacpan.org/pod/MooseX::StrictConstructor>
module ported to Raku as a role.

The test suite is ported as well, except for the parts that don't
make sense in Raku anymore.

I had fun writing this. I hope you enjoy using it too.

=head1 AUTHOR

Tadeusz Sośnierz

=head1 COPYRIGHT AND LICENSE

Copyright 2014 - 2019 Tadeusz Sośnierz

Copyright 2024 Raku Community

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod

# vim: expandtab shiftwidth=4
