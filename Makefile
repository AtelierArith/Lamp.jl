.PHONY : all build page slideshow docs app test clean

DOCKER_IMAGE=lampjl     

all: build

config/secrets.jl:
	julia --project=@. -e 'using Genie; Genie.Generator.write_secrets_file()'

build: config/secrets.jl
	docker build -t ${DOCKER_IMAGE} . --build-arg NB_UID=`id -u`
	docker-compose build

slideshow:
	julia --project=slideshow -e 'import Pkg; Pkg.instantiate()'
	julia --project=slideshow slideshow/make.jl
	mkdir -p slideshow/lamp/build
	mv slideshow/lamp/src/index.html slideshow/lamp/build/index.html

page: slideshow
	julia --project=page -e 'import Pkg; Pkg.instantiate()'
	julia --project=page page/make.jl
	mkdir -p page/__site/slideshow/lamp/build
	cp -r slideshow/lamp/build page/__site/slideshow/lamp

docs: page
	julia --project=page -e 'using LiveServer; serve(dir="page/__site")'

app: build
	docker-compose up app

test: build
	docker-compose run --rm shell julia -e 'using Pkg; Pkg.activate("."); Pkg.test()'

clean:
	docker-compose down
	-rm -rf config
	-rm -rf node_modules package-lock.json pages/__site
	-rm -rf log
