FROM python:3.9

WORKDIR /app/backend

COPY requirements.txt /app/backend/
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

RUN pip install mysqlclient  
RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/backend

EXPOSE 8000

ENV MYSQL_HOST=db-host \
    MYSQL_USER=db-user \
    MYSQL_PASSWORD=db-pass \
    MYSQL_DATABASE=db-name

CMD python /app/backend/manage.py runserver 0.0.0.0:8000
