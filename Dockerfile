# Сборка сайта документации и публикация через nginx.
#   docker build -t paybridge-docs .
#   docker run -d -p 8080:80 paybridge-docs   -> http://localhost:8080
FROM python:3.12-slim AS build
WORKDIR /src
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
# Внутренний PlantUML-сервер можно передать при сборке: --build-arg PLANTUML_SERVER=http://...
ARG PLANTUML_SERVER=https://www.plantuml.com/plantuml
ENV PLANTUML_SERVER=${PLANTUML_SERVER}
RUN for p in admin integration; do (cd $p && mkdocs build -q -d /tmp/$p); done \
 && mkdocs build --strict -d /site

FROM nginx:1.27-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /site /usr/share/nginx/html
