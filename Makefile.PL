use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'CanvasJS',
    AUTHOR           => q{Matt Spaulding <mspaulding06@gmail.com>},
    VERSION_FROM     => 'lib/CanvasJS.pm',
    ABSTRACT_FROM    => 'lib/CanvasJS.pm',
    LICENSE          => 'Artistic_2_0',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        'Mojo::JSON' => 0,
        'String::Random' => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'CanvasJS-*' },
);
