# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir Flask requests

# Copy the current directory contents into the container at /app
COPY registrationToEntities.py .

# Make port 5055 available to the world outside this container
EXPOSE 8888

# Run app.py when the container launches
CMD ["python3", "/app/registrationToEntities.py"]