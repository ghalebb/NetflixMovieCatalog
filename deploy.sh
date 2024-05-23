#!/bin/bash

cd ~/app


if [ ! -d "venv" ]; then
  python3 -m venv venv
fi

source venv/bin/activate

pip install -r requirements.txt

nohup venv/bin/python app.py &

deactivate


