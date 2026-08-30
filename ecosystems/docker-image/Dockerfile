FROM python:3.12-slim

LABEL org.opencontainers.image.title="aitextcleaner-formatting-residue"
LABEL org.opencontainers.image.version="0.2.0"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.url="https://aitextcleaner.pro/"
LABEL org.opencontainers.image.source="https://aitextcleaner.pro/"

COPY app.py /opt/aitextcleaner/app.py
COPY entrypoint.sh /usr/local/bin/aitextcleaner-formatting-residue
RUN chmod +x /usr/local/bin/aitextcleaner-formatting-residue
ENTRYPOINT ["/usr/local/bin/aitextcleaner-formatting-residue"]
