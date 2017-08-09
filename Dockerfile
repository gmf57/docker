from python:3-slim

RUN echo 'APT::Get::Assume-YES "true";' >> /etc/apt/apt.conf \
    && apt-get update \
    && apt-get install sudo \
    bash \
    libtk8.6 \
    git

COPY requirements.txt ./
COPY notebook.mplstyle /root/.config/matplotlib/stylelib/notebook.mplstyle
RUN pip install --no-cache-dir -r requirements.txt && \
    git config --global user.email gmf57@cornell.edu

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer


CMD ["bash"]
