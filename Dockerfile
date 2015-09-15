FROM ubuntu:wily
# ...
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get -y install gcc wget
RUN apt-get -y install make cpanminus perl-tk perl-modules libtest-simple-perl libperl-ostype-perl libversion-perl libversion-requirements-perl libmodule-metadata-perl libmodule-build-perl libjson-pp-perl
RUN apt-get -y install libfile-which-perl libtext-iconv-perl libtext-micromason-perl libtie-ixhash-perl libsyntax-highlight-engine-simple-perl libxml-namespacesupport-perl libxml-sax-base-perl libxml-sax-perl libxml-libxml-perl libxml-libxslt-perl
RUN apt-get -y install libxml-nodefilter-perl libxml-libxml-iterator-perl libxml-filter-buffertext-perl libxml-sax-writer-perl libxml-writer-perl libparse-recdescent-perl libgraph-perl libperlio-gzip-perl libarchive-zip-perl libio-string-perl
RUN apt-get -y install libclass-inspector-perl libfile-sharedir-perl libreadonly-perl libfont-ttf-perl libpdf-api2-perl libxml2-dev
RUN cpanm UNIVERSAL::DOES XML::CompactTree XML::CompactTree::XS
RUN cpanm -f Treex::PML
RUN cpanm Moose MooseX::Getopt MooseX::NonMoose MooseX::Params::Validate MooseX::SemiAffordanceAccessor Readonly Treex::PML File::Slurp File::HomeDir File::Path File::ShareDir LWP::Simple Data::Dumper Module::Reload Locale::Language 
RUN cpanm -f Parse::RecDescent 
RUN cpanm Cwd Scalar::Util autodie String::Util
RUN cpanm -f PerlIO::Util
RUN cpanm File::ShareDir::Install File::chdir YAML IO::Interactive PerlIO::via::gzip Test::Output Test::YAML Test::Base Algorithm::Diff Text::Diff Spiffy Capture::Tiny
RUN cpanm -f Treex::Core
ENV TMT_ROOT=${HOME}/tectomt/
ENV PATH="${TMT_ROOT}/treex/bin:$PATH"
ENV PERL5LIB="${TMT_ROOT}/treex/lib:${TMT_ROOT}/libs/other:$PERL5LIB"
ENV PERLLIB=$PERL5LIB
RUN URL='http://ufal.mff.cuni.cz/tred/tred_2.5049_all.deb'; FILE=`mktemp`; wget "$URL" -qO $FILE && dpkg -i $FILE
RUN mkdir -p $TMT_ROOT/share/
RUN ln -s /opt/tred $TMT_ROOT/share/
RUN ln -s /tmp $TMT_ROOT/tmp
RUN echo "tred_dir: $TMT_ROOT/share/tred" >> ~/.treex/config.yaml
# socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &
# ifconfig vboxnet0
# docker run --rm -e DISPLAY=192.168.99.1:0 -i -t -v /Users/wroberts/Documents/Berlin/qtleap/docker/tred/sshfs:/clou docker-tred ttred
#
# http://www.larkinweb.co.uk/computing/mounting_file_systems_over_two_ssh_hops.html
#
# cd /Users/wroberts/Documents/Berlin/qtleap/docker/tred
# mkdir -p sshfs
# ssh -f amor -L 2222:clou:22 -N
# sshfs -p 2222 robertsw@localhost:/work/robertsw/qtleap/qtleap sshfs
