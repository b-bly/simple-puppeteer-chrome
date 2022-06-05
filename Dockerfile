# https://dev.to/cloudx/how-to-use-puppeteer-inside-a-docker-container-568c

FROM node:16-slim AS app

# We don't need the standalone Chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
COPY . /

# Install Google Chrome Stable and fonts
RUN apt-get update \
    && apt-get install -y wget gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && rm -rf /var/lib/apt/lists/*
# Note: this installs the necessary libs to make the browser work with Puppeteer.
RUN npm install
RUN npx install-chrome-dependencies

ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome

RUN npm i

ENTRYPOINT [ "node", "server.js" ]
