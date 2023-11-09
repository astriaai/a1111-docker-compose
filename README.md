# Automatic1111 SD-WEBUI Docker Compose

```bash

docker compose build webui
mkdir -p ~/a1111-docker-compose/models
curl -Lo ~/a1111-docker-compose/models/Stable-diffusion/models/rv51-inpainting.safetensors "https://civitai.com/api/download/models/130090"
curl -Lo ~/a1111-docker-compose/models/Stable-diffusion/rv51.safetensors "https://civitai.com/api/download/models/130072?type=Model&format=SafeTensor&size=pruned&fp=fp16"
curl -Lo ~/a1111-docker-compose/models/Stable-diffusion/control_v11p_sd15_openpose.pth "https://huggingface.co/lllyasviel/ControlNet-v1-1/resolve/main/control_v11p_sd15_openpose.pth"
curl -Lo ~/a1111-docker-compose/models/ESRGAN/4xUltrasharp_4xUltrasharpV10.pt "https://civitai.com/api/download/models/125843"
docker compose run 
```
