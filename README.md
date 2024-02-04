# Installation

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

# Testing

To check if the installation was successful, you can run the following command:

```bash
python3 test_celery.py [-m <message>]
```
