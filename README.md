# V2Ray Websocket Docker Image

1. Install docker on your server:
```
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
```

2. Download `docker-compose.yml`
```
mkdir ~/v2ray/
cd ~/v2ray/
wget https://github.com/yeganemehr/v2ray-ws/raw/master/docker-compose.yml
```

3. Config V2ray
```
cd ~/v2ray/
cat <<EOT >> v2ray.json
{
	"inbounds": [
		{
			"port": 10000,
			"listen": "127.0.0.1",
			"protocol": "vmess",
			"settings": {
				"clients": [
					{
						"id": "42a1e0a7-7a78-4db2-ab49-a5014d1f38ed"
					}
				]
			},
			"streamSettings": {
				"network": "ws",
				"wsSettings": {
					"path": "/connect"
				}
			}
		}
	],
	"outbounds": [
		{
			"protocol": "freedom",
			"settings": {}
		}
	]
}
EOT

```

4. Spin up the docker container:
```
docker compose up -d
```