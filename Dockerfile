FROM python:3.14.4
WORKDIR /usr/local/project

# Install app dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY app ./app
EXPOSE 8000

# Setup a user
RUN useradd app
USER app

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]

