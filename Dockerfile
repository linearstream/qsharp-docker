FROM fedora

MAINTAINER breakdownlane

# Setup public key for Microsoft and add repo to yum
ENV MS_PKGS_URL https://packages.microsoft.com
RUN rpm --import ${MS_PKGS_URL}/keys/microsoft.asc && \
    curl --silent --output /etc/yum.repos.d/microsoft-prod.repo ${MS_PKGS_URL}/config/fedora/30/prod.repo

# Install pip for installing Python packages and .NET for installing Q#
RUN dnf install --assumeyes pip dotnet-sdk-3.0

# Install Python Q# package
# and jupyter notebook for those that want to use that development environment
RUN pip install qsharp jupyterlab

# Install the .NET Q# package
RUN dotnet tool install --tool-path /usr/local/bin Microsoft.Quantum.IQSharp && \
    dotnet-iqsharp install

# Setup environment for running python3
ENV QSHARP_EXAMPLE_DIR /mnt/src
RUN mkdir -p ${QSHARP_EXAMPLE_DIR}
WORKDIR ${QSHARP_EXAMPLE_DIR}

# NOTE: It is expected that the user must mount their own directory containing their qsharp code
# Example:
#   > docker run --mount type=bind,src=$(pwd),target=/mnt/src jwt/qsharp hello_world.py
#   Preparing Q# environment...
#   ...Hello from quantum world!
#   
# In this example, hello_world.py and Operation.qs are in pwd and hello_world.py gets run.
# 

# Pass the file to run as an argument to the docker run command or just type python commands into py repl
ENTRYPOINT ["python3"]
