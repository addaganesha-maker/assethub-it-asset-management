FROM node:20-bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends iputils-ping unzip \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY AssetHub-API-Source.zip /tmp/AssetHub-API-Source.zip
RUN unzip -q /tmp/AssetHub-API-Source.zip -d /app \
  && rm /tmp/AssetHub-API-Source.zip

WORKDIR /app
RUN npm ci --omit=dev && npx playwright install --with-deps chromium

VOLUME ["/app/storage"]
EXPOSE 10000
CMD ["node", "src/index.js"]
