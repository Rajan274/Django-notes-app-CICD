# ---------- Stage 1: Builder ----------
FROM python:3.9-slim AS builder

WORKDIR /app

RUN apt-get update && \
    apt-get install -y gcc default-libmysqlclient-dev pkg-config && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --upgrade pip

RUN pip install --prefix=/install mysqlclient
RUN pip install --prefix=/install --no-cache-dir -r requirements.txt


# ---------- Stage 2: Runtime ----------
FROM python:3.9-slim

WORKDIR /app

RUN apt-get update && \
    apt-get install -y default-libmysqlclient-dev && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /install /usr/local

COPY . .

EXPOSE 8000

CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
