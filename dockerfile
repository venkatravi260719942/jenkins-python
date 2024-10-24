# Use Python base image
FROM python:3.7

# Install necessary packages including Nginx
RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
COPY . /app
WORKDIR /app

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt && \
    pip install pytest

# Remove the default Nginx config and copy our custom one
RUN rm /etc/nginx/sites-enabled/default
COPY nginx.conf /etc/nginx/conf.d/

# Expose port 80 for Nginx
EXPOSE 80

# Expose the Flask application port (optional based on how you proxy)
EXPOSE 8585

# Start Nginx and the Flask application
# CMD service nginx start && python app.py
CMD ["sh", "-c", "service nginx start && python app.py"]
