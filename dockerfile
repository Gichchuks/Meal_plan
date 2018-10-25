FROM ruby:2.3.3

RUN apt-get update -yqq
	&& apt-get install -yqq --no-install-recommends \
	sqlite3-client \
	nodejs \
	&& apt-get -q clean \
	&& rm -rf /var/lib/apt/lists

# pre-install gem with native extensions
RUN gem install nokogiri -v "1.6.8"

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install 
COPY . .

CMD rails server -b 0.0.0.0