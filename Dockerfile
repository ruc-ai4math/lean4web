# syntax=docker/dockerfile:1.7

ARG NODE_IMAGE=node:25-bookworm-slim

FROM ${NODE_IMAGE} AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    xz-utils \
    zstd \
  && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh | sh -s -- -y

ENV PATH="/root/.elan/bin:${PATH}"

WORKDIR /app

COPY package.json package-lock.json ./
COPY client/package.json ./client/package.json
COPY server/package.json ./server/package.json

RUN npm ci

COPY . .

ARG LEANWEB_BUILD_PROJECT=MathlibDemo
ARG LEANWEB_PROJECT_VERSION=master

ENV PROJECTS_BASE_PATH=ProjectsDocker
ENV LEANWEB_PROJECT_VERSION=${LEANWEB_PROJECT_VERSION}

RUN mkdir -p "/app/${PROJECTS_BASE_PATH}" \
  && cp -a "/app/Projects/${LEANWEB_BUILD_PROJECT}" "/app/${PROJECTS_BASE_PATH}/${LEANWEB_BUILD_PROJECT}"

RUN npm run build \
  && test -f "/app/${PROJECTS_BASE_PATH}/${LEANWEB_BUILD_PROJECT}/lake-manifest.json" \
  && test -f "/app/${PROJECTS_BASE_PATH}/${LEANWEB_BUILD_PROJECT}/lean-toolchain" \
  && test -d "/app/${PROJECTS_BASE_PATH}/${LEANWEB_BUILD_PROJECT}/.lake/packages/mathlib"

FROM ${NODE_IMAGE} AS runtime

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates \
    bubblewrap \
    git \
  && rm -rf /var/lib/apt/lists/*

ENV PATH="/root/.elan/bin:${PATH}"
ENV NODE_ENV=production
ENV PROJECTS_BASE_PATH=ProjectsDocker
ENV NO_BWRAP=false
ENV PORT=8080

WORKDIR /app

COPY package.json package-lock.json ./
COPY client/package.json ./client/package.json
COPY server/package.json ./server/package.json

RUN npm ci --omit=dev

COPY --from=builder /root/.elan /root/.elan
COPY --from=builder /app/server /app/server
COPY --from=builder /app/client/dist /app/client/dist
COPY --from=builder /app/ProjectsDocker /app/ProjectsDocker

EXPOSE 8080

CMD ["node", "server/index.mjs"]
