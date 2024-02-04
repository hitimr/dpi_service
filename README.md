# Installation

Install the following dependecies:

```bash
# Install redis server and python dependencies
sudo apt install redis-server
pip install -r requirements.txt

# Start the redis server
sudo service redis-server start

# Test if the server is running
redis-cli ping
```
