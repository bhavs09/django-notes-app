FROM python:3.9

WORKDIR /app/backend

# Copy and install dependencies
COPY requirements.txt /app/backend/
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy your Django code
COPY . /app/backend

# Expose port 8000
EXPOSE 8000

# Environment variables for DB (change these later if needed)
ENV MYSQL_HOST=db-host \
    MYSQL_USER=db-user \
    MYSQL_PASSWORD=db-pass \
    MYSQL_DATABASE=db-name

# Copy entrypoint and make it executable
COPY entrypoint.sh /app/backend/entrypoint.sh
RUN chmod +x /app/backend/entrypoint.sh

# Use entrypoint to run migrations and then the server
ENTRYPOINT ["/app/backend/entrypoint.sh"]

