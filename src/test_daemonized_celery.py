from celery import Celery

if __name__ == "__main__":
    # Initialize Celery app with both broker and backend set to Redis
    app = Celery(
        "tasks",
        broker="redis://localhost:6379/0",
        backend="redis://localhost:6379/0",
    )

    message = "Hello, World!"

    result = app.send_task("tasks.ping", args=[message])

    # Attempt to get the result with a timeout
    try:
        response = result.get(timeout=10)  # Adjust timeout as needed
        print("Task response:", response)
    except Exception as e:
        print("Error getting task result:", e)
