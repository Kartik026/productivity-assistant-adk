FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY productivity_assistant/ ./productivity_assistant/
COPY entrypoint.sh .
RUN chmod +x /app/entrypoint.sh

# Download toolbox binary — correct GCS bucket
RUN curl -sSfL \
  "https://storage.googleapis.com/genai-toolbox/v0.10.0/linux/amd64/toolbox" \
  -o /app/toolbox && chmod +x /app/toolbox && \
  echo "✅ Toolbox size:" && ls -lh /app/toolbox

EXPOSE 8080
CMD ["/app/entrypoint.sh"]
