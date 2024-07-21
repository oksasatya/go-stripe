STRIPE_SECRET=sk_test_51K8l9eLvRiE9xq0NuPCaAFWpPgHuvoQhBJKx68OYL54PAqtBIwK1PIZlZajM2rcALT1MXZNMbDD4Hu5sV0AKfLp600vD9kc0Ba
STRIPE_KEY=pk_test_51K8l9eLvRiE9xq0N4LL2a77EnZZDazyr18ZYNyB5LxuHQyhCAcdbITz7c03Av0uH1oqlupceWulILfYI40YHV6Nd00nKqPzR8a
GOSTRIPE_PORT=4000
API_PORT=4001


## build: builds all binaries
build: clean build_front build_back
	@echo All binaries built!

## clean: cleans all binaries and runs go clean
clean:
	@echo Cleaning...
	@echo y | DEL /S dist
	@go clean
	@echo Cleaned and deleted binaries

## build_front: builds the front end
build_front:
	@echo Building front end...
	@go build -o dist/gostripe.exe ./cmd/web
	@echo Front end built!

## build_back: builds the back end
build_back:
	@echo Building back end...
	@go build -o dist/gostripe_api.exe ./cmd/api
	@echo Back end built!

## start: starts front and back end
start: start_front start_back

## start_front: starts the front end
start_front: build_front
	@echo "Starting the front end..."
	@start /min cmd /c /v "set STRIPE_KEY=${STRIPE_KEY}&& set STRIPE_SECRET=${STRIPE_SECRET}" dist\gostripe.exe -port=${GOSTRIPE_PORT} &
	@echo "Front end running!"

## start_back: starts the back end
start_back: build_back
	@echo Starting the back end...
	@start /min cmd /c /v "set STRIPE_KEY=${STRIPE_KEY}&& set STRIPE_SECRET=${STRIPE_SECRET}" dist\gostripe_api.exe -port=${API_PORT}
	@echo "Back end running!"

## stop: stops the front and back end
stop: stop_front stop_back
	@echo "All applications stopped"

## stop_front: stops the front end
stop_front:
	@echo "Stopping the front end..."
	@taskkill /IM gostripe.exe /F
	@echo "Stopped front end"

## stop_back: stops the back end
stop_back:
	@echo "Stopping the back end..."
	@taskkill /IM gostripe_api.exe /F
	@echo "Stopped back end"