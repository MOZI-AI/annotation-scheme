FROM xabush/annotation-scheme:0.1
MAINTAINER Abdulrahman Semrie

WORKDIR $HOME
RUN git clone https://git.savannah.nongnu.org/git/nyacc.git && \
    cd nyacc && \
    ./configure && \
    make && \
    make install

WORKDIR $HOME
RUN git clone https://github.com/Habush/guile-json.git && \
    cd guile-json && \
    autoreconf -vif && \
    ./configure  && \
    make && \
    make install

WORKDIR $HOME

RUN git clone https://github.com/MOZI-AI/annotation-scheme.git && \
    cd annotation-scheme && \
    autoreconf -vif && \
    ./configure  && \
    make && \
    make install

WORKDIR $HOME