docker run -it --rm `
    -v "$(pwd)/pythonscript:/src" `
    python:3.13 python /src/app.py