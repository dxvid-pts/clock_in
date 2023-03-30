FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /App

#setup ENV vars
ARG MARIADB_HOST
ARG MARIADB_DATABASE 
ARG MARIADB_USER 
ARG MARIADB_PASSWORD 
ARG MARIADB_PORT 

# Copy everything
COPY . ./

# Restore as distinct layers
RUN dotnet restore

# add db config
RUN dotnet user-secrets set ConnectionStrings:Database "server=$MARIADB_HOST;port=$MARIADB_PORT;database=$MARIADB_DATABASE;user=$MARIADB_USER;password=$MARIADB_PASSWORD"

# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "backend.dll"]