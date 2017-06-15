## Containerized cpu-only MapD configured for read only data
### Usage

Load data
```bash
cd data
docker-compose up
cd ..
```

Start mapd servers and nginx load balancer
```bash
docker-compose up -d
```
