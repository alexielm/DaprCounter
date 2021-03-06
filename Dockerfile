FROM mcr.microsoft.com/dotnet/runtime:5.0-buster-slim AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:5.0-buster-slim AS build
WORKDIR /src
COPY ["DaprCounter.csproj", "./"]
RUN dotnet restore "DaprCounter.csproj"
COPY . .
WORKDIR "/src/"
RUN dotnet build "DaprCounter.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DaprCounter.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DaprCounter.dll"]
