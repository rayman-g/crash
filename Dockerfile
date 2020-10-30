FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster AS builder
WORKDIR /dotnet
COPY . /dotnet
RUN dotnet publish -o output -c Debug -r linux-x64 --self-contained

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-buster
WORKDIR /dotnet
COPY --from=builder /dotnet/output .
COPY notes.txt /notes.txt
ENTRYPOINT ["dotnet", "crash.dll"]
