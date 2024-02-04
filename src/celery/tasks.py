from celery import Celery

REDIS_URL = "redis://localhost:6379/0"


# Configure Celery to use Redis as the message broker
app = Celery(
    "tasks",
    broker=REDIS_URL,  # Redis server running on localhost
    backend=REDIS_URL,
    broker_connection_retry_on_startup=True,
)


# Define a simple task
@app.task
def ping(message):
    return message
