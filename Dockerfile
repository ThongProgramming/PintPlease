FROM phusion/passenger-full:0.9.14

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

#   Build system and git.
RUN /build/utilities.sh

#   Ruby support.
#RUN /build/ruby1.9.sh
#RUN /build/ruby2.0.sh
RUN /build/ruby2.1.sh
#   Python support.
#RUN /build/python.sh
#   Node.js and Meteor support.
#RUN /build/nodejs.sh

# Load app
RUN mkdir /myapp
WORKDIR /myapp

# Prep app
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
ADD . /myapp

RUN bundle install

EXPOSE 22