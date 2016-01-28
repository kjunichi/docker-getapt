FROM ubuntu-debootstrap:14.04
COPY ./cedar.sh /tmp/build.sh
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive /tmp/build.sh
RUN curl -L http://cpanmin.us | perl - App::cpanminus
RUN cpanm File::NCopy
WORKDIR /root
ONBUILD ADD aptlist.txt /root/aptlist.txt
ADD aptlist.pl /root/aptlist.pl
RUN chmod +x /root/aptlist.pl
RUN find /usr |sort > /root/before.txt
ONBUILD RUN cat aptlist.txt|xargs apt-get install -y --no-install-recommends
ONBUILD RUN find /usr |sort > after.txt
ONBUILD RUN diff before.txt after.txt > list.txt || exit 0
ONBUILD RUN grep '^>' list.txt| sed -e 's/> //g' > src.txt
ONBUILD RUN ./aptlist.pl src.txt && tar jcf bin.tar.bz2 app
CMD ["bash"]
