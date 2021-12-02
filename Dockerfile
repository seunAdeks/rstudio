ARG BASE_IMAGE=rocker/verse:latest
FROM $BASE_IMAGE
# rocker/tidyverse:3.6.3
# bioconductor/bioconductor_docker:devel

LABEL org.opencontainers.image.source https://github.com/MaastrichtU-IDS/rstudio
# Source Dockerfile: https://github.com/rocker-org/rocker-versioned/blob/master/rstudio/3.6.3.Dockerfile

ENV ADD=shiny
# ENV ROOT=true

# Install Shiny server
# COPY add_shiny.sh /etc/cont-init.d/add
# RUN bash /etc/cont-init.d/add

# Install ZSH
USER root
RUN apt-get update -q && \
    apt-get install -y zsh
USER rstudio

# Install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN wget -O ~/.oh-my-zsh/custom/themes/vemonet_bira.zsh-theme https://raw.githubusercontent.com/vemonet/zsh-theme-biradate/master/zsh/vemonet_bira.zsh-theme
RUN sed -i 's/robbyrussell/vemonet_bira/g' ~/.zshrc

# Set default shell to ZSH
ENV SHELL=/bin/zsh
USER root
RUN chsh -s /bin/zsh 
USER rstudio

# Expose Shiny server
EXPOSE 3838