FROM ruby:2.3.1

RUN apt-get update -q
#RUN apt-get install -qy nginx
RUN apt-get install -qy curl
RUN apt-get install -qy nodejs
RUN apt-get install -y --force-yes libpq-dev

#RUN echo "daemon off;" >> /etc/nginx/nginx.conf
#RUN chown -R www-data:www-data /var/lib/nginx

RUN gem install bundler
RUN gem install foreman
RUN gem install rails

#ADD config/container/nginx-sites.conf /etc/nginx/sites-enabled/default

ADD ./ /rails

WORKDIR /rails
COPY Gemfile /rails/
COPY Gemfile.lock /rails/
RUN bundle install

#ADD Gemfile /rails/
#ADD Gemfile.lock /rails/


ENV RAILS_ENV production
ENV PORT 3000

RUN bundle install

#RUN /bin/bash -l -c "bundle install --without development test"

EXPOSE 8080

#CMD bundle exec rake db:create db:migrate && foreman start -f Procfile
