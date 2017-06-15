## Containerized cpu-only MapD configured for read only data
### Usage

Load data
```bash
cd data
dc up
cd ..
```

Start mapd servers and nginx load balancer
```bash
dc up -d
```
