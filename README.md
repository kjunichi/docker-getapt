# docker-getapt

for those people who using heroku with Docker.

## Usage 

### Step 1. Build kjunichi/apt image.

```bash
git clone https://github.com/kjunichi/docker-getapt.git
cd docker-getapt
docker build -t kjunichi/getapt .
```

### Step2. Use this image

You need to make Dockerfile like this:

```dockerfile
FROM kjunichi/aptget
```

write files what you want, and name it aptlist.txt.

```txt
jq
libcairo2-dev
libjpeg8-dev
libpango1.0-dev
libgif-dev
```

### Step 3. get files which was installed by apt-get command.

```bash
docker build -t files .
docker run -d -t files --name getapt
docker exec getapt cat bin.tar.bz2 > dest.tar.bz2
docker stop getapt
```
