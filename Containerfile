FROM registry.access.redhat.com/ubi9/python-311:latest

USER 0
RUN dnf update -y && \
    dnf install -y sqlite-devel && \
    dnf clean all

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    __pysqlite3_lib_path__=/opt/app-root/lib64/python3.11/site-packages/pysqlite3

WORKDIR /app
COPY pyproject.toml .
RUN pip install --no-cache-dir --upgrade pip setuptools wheel && \
    pip install --no-cache-dir .
COPY . .

EXPOSE 8501
USER 1001
ENTRYPOINT [ "streamlit", "run", "crew_ai_crew.py" ]
