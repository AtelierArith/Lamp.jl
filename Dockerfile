FROM julia:1.9.3

# Create and change to the app directory.
WORKDIR /app
ENV JULIA_DEPOT_PATH /app/.julia
# Please run the following command in advance
# on your host to generate Manifest.toml
# `julia --project=@. -e 'using Pkg; Pkg.instantiate()'
COPY Project.toml Manifest.toml .
COPY lib ./lib
# Please generate `config/secrets.jl` to run a Genie application properly
# with production mode (namely with `GENIE_ENV=prod`), or it will fail running on Google Cloud Platform.
# Just run:
# `julia --project=@. -e 'using Genie; Genie.Generator.write_secrets_file()'`
COPY config ./config
COPY app.jl app.jl.html .
COPY server.jl .

RUN julia --project=/app -e "using Pkg; Pkg.instantiate(); Pkg.precompile()"

EXPOSE 8080
EXPOSE 80
ENV JULIA_REVISE "off"
ENV GENIE_ENV "prod"
ENV GENIE_HOST "0.0.0.0"
ENV PORT "8080"
ENV WSPORT "8080"

CMD ["julia", "--project=/app", "/app/server.jl"]
