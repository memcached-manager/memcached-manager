FROM ruby:1.9.3
RUN mkdir /memcached-manager
WORKDIR /memcached-manager
ADD . /memcached-manager
RUN bundle install
RUN export DISPLAY=:99
RUN /etc/init.d/xvfb start
