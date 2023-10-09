FROM ubuntu:22.04

ENV TZ=Europe/Zurich
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update -yq && apt upgrade -yq
RUN apt install -y vim software-properties-common git curl unzip zip sudo \
    sqlite3 wget unzip locales
RUN sudo locale-gen "en_US.UTF-8"
RUN update-locale LC_ALL="en_US.UTF-8"
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
RUN pip3 install seaborn pandas matplotlib pytest matplotlib_venn

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
 
# Install Maven
ADD ./installation_scripts/install_maven.sh ${HOME}/installation_scripts/install_maven.sh
RUN ${HOME}/installation_scripts/install_maven.sh
 
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

ADD ./scripts/utils/fetch-package-data.sh /usr/local/bin/fetch-package-data
ADD ./scripts/utils/doc2json.sh /usr/local/bin/doc2json-util
RUN echo "export PATH=$PATH:/home/thalia/.local/bin" >> ${HOME}/.bash_profile

# Add source code of hephaestus
ADD ./hephaestus ${HOME}/hephaestus
RUN sudo chown -R thalia:thalia ${HOME}/hephaestus

# Install and run hephaestus
RUN cd ${HOME}/hephaestus/ && pip install . && python -m pytest

# Add source code of thalia
ADD ./thalia ${HOME}/thalia
RUN sudo chown -R thalia:thalia ${HOME}/thalia

# Install and run thalia
RUN cd ${HOME}/thalia/ && pip install . && python -m pytest

# Add source code of doc2json
ADD ./doc2json ${HOME}/doc2json
RUN sudo chown -R thalia:thalia ${HOME}/doc2json

# Install doc2json
RUN cd ${HOME}/doc2json/ && pip install .

# Create directory for helper scripts
RUN mkdir ${HOME}/scripts
ADD ./scripts/compute_coverage.sh ${HOME}/scripts
ADD ./scripts/config.sh ${HOME}/scripts
RUN sudo chown -R thalia:thalia ${HOME}/scripts/compute_coverage.sh
RUN sudo chown -R thalia:thalia ${HOME}/scripts/config.sh

# Create directory for runner scripts
RUN mkdir ${HOME}/runner_scripts
ADD ./runner_scripts/create-api-rules.py ${HOME}/runner_scripts
ADD ./runner_scripts/thalia_run.sh ${HOME}/runner_scripts
RUN sudo chown -R thalia:thalia ${HOME}/runner_scripts/create-api-rules.py
RUN sudo chown -R thalia:thalia ${HOME}/runner_scripts/thalia_run.sh

# Add stdlibs 
ADD ./stdlib/ ${HOME}/stdlib

# Add example files
# TODO: we should attach that as a volume
RUN mkdir ${HOME}/example-libraries
ADD ./example-libraries ${HOME}/example-libraries
RUN sudo chown -R thalia:thalia ${HOME}/example-libraries

WORKDIR ${HOME}
