FROM nginx:stable-alpine
RUN apk --no-cache add --virtual .dev zip && \
	apk --no-cache add supervisor && \
	mkdir -p /tmp/v2ray /etc/v2ray /etc/supervisor.d/ && \
	cd /tmp/v2ray && \
	wget https://github.com/v2fly/v2ray-core/releases/download/v4.31.0/v2ray-linux-64.zip && \
	unzip v2ray-linux-64.zip && \
	mv v2ray v2ctl geoip.dat geosite.dat /usr/bin/ && \
	cd / && \
	rm -fr /tmp/v2ray && \
	apk del --no-network .dev && \
	touch /etc/v2ray/config.json

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY supervisor.ini /etc/supervisor.d/main.ini

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]