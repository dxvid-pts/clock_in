FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /App

#setup ENV vars
ENV MARIADB_HOST="mariadb"
ENV MARIADB_DATABASE="clock_in"
ENV MARIADB_USER="test"
ENV MARIADB_PASSWORD="test"

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore

# add db config
RUN dotnet user-secrets set ConnectionStrings:Database "server=mariadb;port=5000;database=clock_in;user=dbuser;password=123456"

# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "backend.dll"]