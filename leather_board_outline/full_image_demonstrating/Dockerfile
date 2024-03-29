FROM python:3.10-slim


# Set the working directory in the container
WORKDIR /app

# Copy the Streamlit app script and any other necessary files
COPY streamlite_full_image.py /app/
COPY outline_detection_full_image.py /app/
COPY requirements.txt /app/

# Install the required Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port that Streamlit listens on
EXPOSE 8501

# Run the Streamlit app when the container starts
CMD ["streamlit", "run", "streamlite_full_image.py"]
