#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["ShowRoom.Order.WebApi/ShowRoom.Order.WebApi.csproj", "ShowRoom.Order.WebApi/"]
COPY ["ShowRoom.Messaging.Shared/ShowRoom.Messaging.Shared.csproj", "ShowRoom.Messaging.Shared/"]
COPY ["ShowRoom.Shared/ShowRoom.Shared.csproj", "ShowRoom.Shared/"]
RUN dotnet restore "ShowRoom.Order.WebApi/ShowRoom.Order.WebApi.csproj"
COPY . .
WORKDIR "/src/ShowRoom.Order.WebApi"
RUN dotnet build "ShowRoom.Order.WebApi.csproj" -e \"RabbitMQConfiguration:Host=172.17.0.1\" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "ShowRoom.Order.WebApi.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "ShowRoom.Order.WebApi.dll"]