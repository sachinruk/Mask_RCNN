FROM ubuntu

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    cmake \
    git \
  && rm -rf /var/lib/apt/lists/*

RUN curl -qsSLkO \
      https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-`uname -p`.sh \
    && bash Miniconda3-latest-Linux-`uname -p`.sh -b \
    && rm Miniconda3-latest-Linux-`uname -p`.sh

ENV PATH=/root/miniconda3/bin:$PATH

RUN git clone git@github.com:matterport/Mask_RCNN.git
RUN cd Mask_RCNN
RUN pip install -r requirements.txt
RUN python setup.py install

# Install pycocotools
RUN git clone https://github.com/pdollar/coco.git
RUN cd coco/PythonAPI
RUN make
RUN make install
RUN python setup.py install

VOLUME /notebook
WORKDIR /notebook
EXPOSE 8888

CMD jupyter notebook --allow-root --no-browser --ip=0.0.0.0 --NotebookApp.token=

# RUN conda install -y \
#     h5py \
#     pandas \
#     jupyter \
#     matplotlib \
#     seaborn \
#     scikit-learn \
#     pandas

# RUN conda config --append channels conda-forge

# RUN conda install -y tensorflow keras

# RUN conda clean --yes --tarballs --packages --source-cache


