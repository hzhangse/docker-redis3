FROM redis:3.2

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt-get -y update && \
  apt-get install -y --no-install-recommends --no-install-suggests ruby-redis supervisor wget curl && \
  rm -rf /var/lib/apt/lists/* && \
  REDIS_TRIB_PATH=/usr/local/bin/redis-trib && \
  wget https://raw.githubusercontent.com/antirez/redis/3.2/src/redis-trib.rb -O $REDIS_TRIB_PATH && \
  chmod +x $REDIS_TRIB_PATH && \
  
  

COPY start.sh /
COPY supervisord.conf /
COPY redis.conf /
RUN chmod a+x /start.sh
VOLUME /data
WORKDIR /

EXPOSE 6379

CMD ["./start.sh"]