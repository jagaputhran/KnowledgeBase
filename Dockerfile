# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set the working directory in the container
WORKDIR /app

# Copy the model directory into the container
COPY model/ElasticNet_Model /app/model/ElasticNet_Model

# Copy the prediction script and requirements file into the container
COPY scripts/predict.py /app/predict.py
COPY requirements.txt /app/requirements.txt

# Install dependencies
RUN pip install --no-cache-dir -r /app/requirements.txt

# Expose the port for the model serving
EXPOSE 5000

# Define environment variable
ENV MLFLOW_TRACKING_URI=http://127.0.0.1:5000

# Serve the model
CMD ["mlflow", "models", "serve", "-m", "/app/model/ElasticNet_Model", "--no-conda", "--host", "0.0.0.0", "--port", "5001"]
