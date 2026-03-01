# Use a specific Python base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy the requirements file and install dependencies
COPY src/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Bundle the application source code inside the image
COPY src /app

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
CMD ["python", "server.py"]

