FROM python:3.10-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    libgomp1 \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory in the container
WORKDIR /app

# Copy the Streamlit app script and any other necessary files
COPY csv_ngsild_agent_utils.py /app/
COPY outline_detection_fabric_irregular.py /app/
COPY streamlite_aruco_options.json /app/
COPY streamlite_aruco.py /app/

COPY requirements.txt /app/

# Install the required Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port that Streamlit listens on
EXPOSE 8501

# Run the Streamlit app when the container starts
CMD ["streamlit", "run", "streamlite_aruco.py"]
