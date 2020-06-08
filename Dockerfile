FROM ubuntu:16.04 as basesystemfile
RUN apt-get update

# Needed packages
RUN dpkg --add-architecture i386 
RUN apt-get update && apt-get -y upgrade && apt-get install --no-install-recommends -y \
  git \
  mercurial \
  gcc \
  g++ \
  vim \
  python \
  python-dev \
  python-setuptools \
  qt5-default \
  python-pygraphviz \
  python-kiwi \
  python-pygoocanvas \
  libgoocanvas-dev \
  ipython \
  autoconf \
  cvs \
  bzr \
  unrar \
  gdb \
  valgrind \
  uncrustify \
  flex \
  bison \
  libfl-dev \
  tcpdump \
  gsl-bin \
  libgsl2 \
  libgsl-dev \
  sqlite \
  sqlite3 \
  libsqlite3-dev \
  libxml2 \
  libxml2-dev \
  cmake \
  libc6-dev \
  libc6-dev-i386 \
  libclang-dev \
  llvm-dev \
  automake \
  libgtk2.0-0 \
  libgtk2.0-dev \
  vtun \
  lxc \
  libboost-signals-dev \
  libboost-filesystem-dev \ 
#end ns3
  git make pkg-config g++ zlib1g-dev \
  libfreetype6-dev libjpeg62-dev libpng12-dev libopenjpeg-dev libmad0-dev libfaad-dev \
  libogg-dev libvorbis-dev libtheora-dev liba52-0.7.4-dev libavcodec-dev libavformat-dev \
  libavutil-dev libswscale-dev libavresample-dev libxv-dev x11proto-video-dev libgl1-mesa-dev \
  x11proto-gl-dev linux-sound-base libxvidcore-dev libssl-dev libjack-dev libasound2-dev \
  libpulse-dev libsdl1.2-dev dvb-apps libavcodec-extra libavdevice-dev libmozjs185-dev \
  libghc-glut-dev \
  x264 ffmpeg\
#for wine support
  wine \
#for git clone https
  ca-certificates \
#end evalvid
  && rm -rf /var/lib/apt/lists/*

#####Build evalvid
FROM basesystemfile as evalvid

WORKDIR /home/evalvid
COPY ./evalvid-tool/evalvid/src/ .
#RUN sh ./compile.sh
RUN sh compile-static.sh
RUN mkdir -p /data
CMD ["/bin/bash"]

#####Build ns3
FROM basesystemfile as ns3
# NS-3
# Create working directory
RUN mkdir -p /home/ns3
WORKDIR /home/ns3
COPY ./ns-3/src /home/ns3/
# Downloading and Building ns-3-dev into ns3 image
# RUN sh build-ns3.sh 
RUN sh download-ns3-dev.sh


FROM basesystemfile as ns3evalvid
COPY --from=evalvid /home/evalvid /home/evalvid
COPY --from=evalvid /usr/local/bin/ /usr/local/bin/
COPY --from=ns3 /home/ns3 /home/ns3
WORKDIR /home/ns3
CMD ["/bin/bash"]
