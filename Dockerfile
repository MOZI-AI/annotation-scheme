FROM xabush/annotation-scheme:0.1
MAINTAINER Abdulrahman Semrie

WORKDIR $HOME
RUN git clone https://github.com/aconchillo/guile-json && \
    cd guile-json && \
    git reset --hard 1.2.0 && \
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
