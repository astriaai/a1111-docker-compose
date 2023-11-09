FROM nvidia/cuda:12.2.0-base-ubuntu22.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
	apt-get install -y aria2 libgl1 libglib2.0-0 wget git git-lfs python3-pip python-is-python3 && \
	pip install -q torch==2.0.1+cu118 torchvision==0.15.2+cu118 torchaudio==2.0.2+cu118 torchtext==0.15.2 torchdata==0.6.1 --extra-index-url https://download.pytorch.org/whl/cu118 && \
	pip install xformers==0.0.20 triton==2.0.0 packaging==23.1 && \
#	adduser --disabled-password --gecos '' user && \
	mkdir /content
#	chown -R user:user /content

WORKDIR /content
#USER user

RUN git clone -b v2.6 https://github.com/camenduru/stable-diffusion-webui /content/test
RUN git clone https://github.com/etherealxx/batchlinks-webui /content/test/extensions/batchlinks-webui
RUN git clone https://github.com/hako-mikan/sd-webui-regional-prompter /content/test/extensions/sd-webui-regional-prompter
RUN git clone https://github.com/Bing-su/adetailer /content/test/extensions/adetailer
RUN sed -i -e 's/    start()/    #start()/g' /content/test/launch.py
WORKDIR /content/test
RUN python launch.py --skip-torch-cuda-test
RUN git reset --hard

## ADD MORE EXTENSIONS HERE #####
RUN git clone https://github.com/Mikubill/sd-webui-controlnet /content/test/extensions/sd-webui-controlnet

# RUN aria2c --console-log-level=error -c -x 16 -s 16 -k 1M https://huggingface.co/ckpt/sd15/resolve/main/v1-5-pruned-emaonly.ckpt -d /content/test/models/Stable-diffusion -o v1-5-pruned-emaonly.ckpt
#CMD mkdir -p /content/test/models/hypernetworks
CMD python launch.py --xformers --cors-allow-origins=* --api

