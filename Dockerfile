FROM ubuntu:22.04

ENV TZ=Europe/Zurich
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update -yq && apt upgrade -yq
RUN apt install -y vim software-properties-common git curl unzip zip sudo \
    sqlite3 wget unzip locales
RUN sudo locale-gen "en_US.UTF-8"
RUN update-locale LC_ALL="en_US.UTF-8"
#RUN add-apt-repository ppa:deadsnakes/ppa && \
#    apt -yqq update && \
#    apt -yqq install python3.9 python3-pip && \
#    update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1 && \
#    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 1
RUN apt install -yq python3-distutils python3-pip


# Create the thalia user.
RUN useradd -ms /bin/bash thalia && \
    echo thalia:thalia | chpasswd && \
    cp /etc/sudoers /etc/sudoers.bak && \
    echo 'thalia ALL=(ALL:ALL) NOPASSWD:ALL' >> /etc/sudoers
USER thalia
ENV HOME /home/thalia
WORKDIR ${HOME}

# Install missing python packages
RUN pip3 install --upgrade setuptools
RUN pip3 install --upgrade setuptools
RUN pip3 install --upgrade distlib
RUN pip3 install --upgrade pip
RUN pip3 install seaborn pandas matplotlib pytest

USER thalia

RUN touch ${HOME}/.bash_profile
RUN echo "source ${HOME}/.bash_profile" >> ${HOME}/.bashrc
RUN echo 'export LANG="en_US.UTF-8"' >> ${HOME}/.bashrc

# Create directory for helper installation scripts
RUN mkdir ${HOME}/installation_scripts
 
# Install sdkman
ADD ./installation_scripts/install_sdkman.sh ${HOME}/installation_scripts/install_sdkman.sh
RUN ${HOME}/installation_scripts/install_sdkman.sh
ENV SDKMAN_DIR="${HOME}/.sdkman"
 
# Install Java
ADD ./installation_scripts/install_java.sh ${HOME}/installation_scripts/install_java.sh
SHELL ["/bin/bash", "-c"]
RUN source .sdkman/bin/sdkman-init.sh && sdk update
RUN ${HOME}/installation_scripts/install_java.sh
 
# Install Kotlin
ADD ./installation_scripts/install_kotlin.sh ${HOME}/installation_scripts/install_kotlin.sh
RUN ${HOME}/installation_scripts/install_kotlin.sh

# Install Groovy
ADD ./installation_scripts/install_groovy.sh ${HOME}/installation_scripts/install_groovy.sh
RUN ${HOME}/installation_scripts/install_groovy.sh

# Install Scala
ADD ./installation_scripts/install_scala.sh ${HOME}/installation_scripts/install_scala.sh
RUN ${HOME}/installation_scripts/install_scala.sh
 
# Now cleanup helper scripts
RUN sudo rm -rf ${HOME}/installation_scripts

# Coverage dependencies: Install JaCoCo and all compilers
RUN mkdir ${HOME}/coverage
WORKDIR ${HOME}/coverage
## Install JaCoCo
RUN mkdir jacoco && \
    cd jacoco && \
    wget https://search.maven.org/remotecontent\?filepath\=org/jacoco/jacoco/0.8.7/jacoco-0.8.7.zip -O jacoco-0.8.7.zip && \
    unzip jacoco-0.8.7.zip

WORKDIR ${HOME}

# Add source code of hephaestus
ADD ./hephaestus ${HOME}/hephaestus
RUN sudo chown -R thalia:thalia ${HOME}/hephaestus

# Install and run hephaestus
RUN cd ${HOME}/hephaestus/ && pip install . && python -m pytest
RUN echo "export PATH=$PATH:/home/thalia/.local/bin" >> ${HOME}/.bash_profile

WORKDIR ${HOME}
