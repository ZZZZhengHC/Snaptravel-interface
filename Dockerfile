FROM node:latest

RUN wget "https://cache.ruby-lang.org/pub/ruby/2.7/ruby-2.7.2.tar.gz"

RUN tar -xzf ruby-2.7.2.tar.gz

WORKDIR /ruby-2.7.2

RUN ./configure

RUN make

RUN make install

RUN mkdir /infra-coop-takehome

WORKDIR /infra-coop-takehome

COPY package.json .

RUN npm install

COPY . .

RUN gem install bundler -v 2.1.4

RUN bundle install

EXPOSE 5000

CMD ["bundler", "exec", "rspec", "-fd"]