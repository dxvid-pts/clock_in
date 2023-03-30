FROM python:alpine3.17 AS py-env
WORKDIR /App

#setup ENV vars
ARG MARIADB_HOST=database
ARG MARIADB_DATABASE 
ARG MARIADB_USER 
ARG MARIADB_PASSWORD
ARG MARIADB_PORT=3306

# Copy everything
COPY . ./

# Execute python script to change db params
RUN python3 init_db.py $MARIADB_HOST $MARIADB_PORT $MARIADB_DATABASE $MARIADB_USER $MARIADB_PASSWORD

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /App

# Copy everything
COPY --from=py-env /App ./

# Restore as distinct layers
RUN dotnet restore

# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "backend.dll"]