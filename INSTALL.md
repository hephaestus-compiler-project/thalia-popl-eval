To get the artifact, run:

```
git clone --recursive https://github.com/hephaestus-compiler-project/thalia-popl-eval thalia-popl-eval
```

The easiest way to get Thalia and all dependencies required for evaluating 
the artifact (e.g., scalac, kotlinc, JaCoCo) is to download a pre-built Docker 
image from DockerHub. Another option is to build the Docker 
image locally.

We provide a `Dockerfile` to build an image that contain:

* An installation of Python (version 3.10.12).
* An installation of [SDKMAN](https://sdkman.io/).
* An installation of OpenJDK version 11.0.12.
* An installation of `kotlinc` version 1.9.0.
* An installation of `groovyc` version 5.0.0-alpha-2.
* An installation of `scalac` version 3.3.0.
* An installation of the `JaCoCo` Java code coverage library.
* An installation of [thalia](https://github.com/hephaestus-compiler-project/thalia).
* An installation of [hephaestus](https://github.com/hephaestus-compiler-project/hephaestus) (baseline).
* An installation of [doc2json](https://github.com/hephaestus-compiler-project/doc2json)
* A user named `thalia` with sudo privileges.
* Python packages for plotting figures (i.e., `seaborn`, `pandas`, 
and `matplotlib`)

Pull Docker Image from DockerHub
--------------------------------

You can download the Docker image from DockerHub by using the following 
commands:

```
docker pull theosotr/thalia-eval
# Rename the image to be consistent with our scripts
docker tag theosotr/thalia-eval thalia-eval
```

After downloading the Docker image successfully, 
please navigate to the root directory of the artifact:

```
cd thalia-popl-eval
```

Build Docker Image Locally
--------------------------

First enter the `thalia-popl-eval/` directory:

```
cd thalia-popl-eval
```

To build the image (named `thalia-eval`), run the following command 
(estimated running time: ~5 minutes, depending on your internet 
connection):

```
docker build -t thalia-eval --no-cache .
```

NOTE: The image is built upon `ubuntu:22.04`.
