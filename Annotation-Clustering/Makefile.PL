use 5.010;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Annotation::Clustering',
    VERSION_FROM      => 'lib/Annotation/Clustering.pm', # finds $VERSION
    PREREQ_PM         => {
	Test::Pod::Coverage => 0,
    }, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Annotation/Clustering.pm', # retrieve abstract from module
       AUTHOR         => 'Frank Foerster <frf53jh@>') : ()),
);
