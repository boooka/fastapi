FROM python:3.9 as build
ENV PYTHONUNBUFFERED 1
ENV USERNAME fa
WORKDIR /app
RUN apt-get update \
    && apt-get --no-install-recommends install -y gettext locales-all curl tzdata git

RUN adduser --disabled-password --gecos ""  $USERNAME && id $USERNAME
RUN echo export PYTHON_PATH=/usr/local/bin/python >> /home/$USERNAME/.profile

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8000

COPY . .
RUN chown -R $USERNAME:$USERNAME ./

COPY entrypoint.sh entrypoint.sh
CMD ./entrypoint.sh
#CMD ["uvicorn", "main:app", "--reload", "--host", "0.0.0.0"]
