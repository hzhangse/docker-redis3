FROM redis:3.2

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN curl -L https://raw.githubusercontent.com/wayneeseguin/rvm/master/binscripts/rvm-installer | bash -s stable
RUN source ~/.rvm/scripts/rvm && rvm requirements &&rvm instail 2.3.1 && rvm use 2.3.1 --default
RUN apt-get install -y --no-install-recommends --no-install-suggests  supervisor  wget  && \
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