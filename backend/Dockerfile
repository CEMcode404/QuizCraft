# Use the .NET SDK image for development
FROM mcr.microsoft.com/dotnet/sdk:8.0

# Set the working directory inside the container
WORKDIR /workspace

# Copy the project file and restore dependencies
COPY ["/backend.csproj", "."]
RUN dotnet restore "backend.csproj"

# Copy the rest of the source code
COPY / .

# Expose the port the application runs on
EXPOSE 5000

# Set the entry point to run the application
ENTRYPOINT ["dotnet", "watch", "run", "--urls", "http://localhost:5000"]