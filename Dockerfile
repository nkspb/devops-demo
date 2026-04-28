FROM python:3.12-slim

WORKDIR /app

# Install app dependencies
COPY requirements.txt ./
# RUN apt update && apt-get -y install --no-install-recommends libpq-dev
RUN pip install --no-cache-dir -r requirements.txt

# RUN chown appuser:appuser /app

# Setup a user
RUN useradd --create-home appuser &&\
    chown appuser:appuser /app

# Copy source code
COPY --chown=appuser:appuser app ./app
COPY --chown=appuser:appuser tests ./tests
COPY --chown=appuser:appuser pytest.ini ./

USER appuser

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
