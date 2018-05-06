FROM redis:3.2

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get -y update && apt-get install -y  software-properties-common
RUN apt-add-repository ppa:brightbox/ruby-ng && apt-get update && apt-get install ruby2.2 ruby2.2-dev rubygems


RUN apt-get install -y --no-install-recommends --no-install-suggests  supervisor  wget && \
  rm -rf /var/lib/apt/lists/* && \
  gem install redis



RUN wget https://raw.githubusercontent.com/antirez/redis/3.2/src/redis-trib.rb -O /redis-trib.rb && \
  chmod +x /redis-trib.rb

COPY start.sh /
COPY supervisord.conf /
COPY redis.conf /
RUN chmod a+x /start.sh
VOLUME /data
WORKDIR /

EXPOSE 6379

CMD ["./start.sh"]