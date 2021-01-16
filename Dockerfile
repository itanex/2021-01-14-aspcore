FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 5000
ENV ASPNETCORE_URLS=http://*:5000

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["2021-01-15-aspcore.csproj", "./"]
RUN dotnet restore "2021-01-15-aspcore.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "2021-01-15-aspcore.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "2021-01-15-aspcore.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "2021-01-15-aspcore.dll"]
