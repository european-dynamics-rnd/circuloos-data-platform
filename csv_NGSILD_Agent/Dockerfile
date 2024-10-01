# Use an official Python runtime as a parent image
FROM python:3.10-slim

WORKDIR /app

COPY ./requirements.txt /app/requirements.txt
# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt


COPY . /app

ENTRYPOINT [ "python" ]

CMD ["app.py" ]
