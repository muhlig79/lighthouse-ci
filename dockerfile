FROM node:20-bookworm

# Chromium + system deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    chromium \
    ca-certificates \
    git \
    fonts-liberation \
    libnss3 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    libxshmfence1 \
    libdrm2 \
  && rm -rf /var/lib/apt/lists/*

ENV CHROME_PATH=/usr/bin/chromium
ENV LIGHTHOUSE_DIR=/opt/lighthouse

# Clone Lighthouse from GitHub
RUN git clone --depth 1 https://github.com/GoogleChrome/lighthouse.git ${LIGHTHOUSE_DIR}

WORKDIR ${LIGHTHOUSE_DIR}

# Install deps + build
RUN npm ci && npm run build

# Optional: default workdir for outputs
WORKDIR /work
RUN mkdir -p /work/reports

# A simple default command (container stays alive)
CMD ["bash", "-lc", "sleep infinity"]
