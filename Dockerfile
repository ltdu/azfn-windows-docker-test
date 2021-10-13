# escape=`
FROM mcr.microsoft.com/dotnet/core/sdk:3.1-nanoserver-1809 AS installer-env

COPY [".", "/src/dotnet-function-app"]
RUN mkdir C:\homes\site\wwwroot & `
    cd C:\src\dotnet-function-app & `
    dotnet publish --output C:\homes\site\wwwroot

FROM mcr.microsoft.com/azure-functions/dotnet:3.0-nanoserver-1809
ARG arg1
ENV AzureWebJobsScriptRoot=C:\homes\site\wwwroot `
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true `
    AzureWebJobsStorage=$arg1 `
    WEBSITE_HOSTNAME=localhost:48008

COPY --from=installer-env ["C:\\homes\\site\\wwwroot", "C:\\homes\\site\\wwwroot"]