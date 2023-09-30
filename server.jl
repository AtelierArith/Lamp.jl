using GenieFramework
port = parse(Int, get(ENV, "port", "8080"))
host = get(ENV, "GENIE_HOST", "127.0.0.1")
Genie.loadapp()
up(port, host, async=false)
