# Daemonized Celery Worker
This repository contains a simple example of how to daemonize a celery worker. 
The worker is started as a systemd service and runs in a virtual environment.

The service can be tested by running the `test_celery.py` script.

## Installation

Just run the install script:

```bash
./install.sh
```

This will do the following things:

-   Install all required dependencies
-   create a celery system user
-   create a virtual environment for the celery user
-   install the celery worker as a systemd service
-   start the celery worker   

## Testing

To check if the installation was successful, you can run the following command:

```bash
python3 test_celery.py [-m <message>]
```
