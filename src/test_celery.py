from celery import Celery
import argparse

REDIS_URL = "redis://localhost:6379/0"


def main(message):
    """
    Send a message to the Celery worker and print the response.
    The Celery worker should echo the message.

    Args:
        message (str): The message to send to the Celery worker
    """
    app = Celery(
        "tasks",
        broker=REDIS_URL,
        backend=REDIS_URL,
    )

    result = app.send_task("tasks.ping", args=[message])

    # Attempt to get the result with a timeout
    try:
        response = result.get(timeout=10)  # Adjust timeout as needed
        print("Task response:", response)
    except Exception as e:
        print("Error getting task result:", e)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Test if the celery worker is running correctly.")
    parser.add_argument(
        "-m", "--message", type=str, default="Hello, World!", help="The message to send to the Celery worker"
    )

    args = parser.parse_args()
    main(args)
