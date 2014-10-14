FROM phusion/passenger-full:0.9.14

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]

#   Build system and git.
RUN /build/utilities.sh

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
#Enable the insecure key permanently
RUN /usr/sbin/enable_insecure_key

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
