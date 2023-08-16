create-clients:
	LNBITS_EXTENSIONS_DEFAULT_INSTALL="" \
	LNBITS_TITLE="lnbits client" \
	LNBITS_BACKEND_WALLET_CLASS="FakeWallet" \
	LNBITS_DATA_FOLDER="./tests/data" \
	PYTHONUNBUFFERED=1 \
	HOST=0.0.0.0 \
	PORT=5004 \
	poetry run lnbits &
	sleep 7
	rm -rf clients
	mkdir -p clients/browser
	mkdir -p clients/node
	# mkdir -p clients/java
	# mkdir -p clients/python
	# mkdir -p clients/rust
	curl -s http://0.0.0.0:5004/openapi.json > clients/openapi.json
	npx openapi-generator-cli generate -i clients/openapi.json -g typescript-fetch -o clients/browser --additional-properties=npmName=@lnbits/client-browser,supportsES6=true,withInterfaces=true
	npx openapi-generator-cli generate -i clients/openapi.json -g typescript-node -o clients/node --additional-properties=npmName=@lnbits/client,supportsES6=true,withInterfaces=true
	# npx openapi-generator-cli generate -i clients/openapi.json -g java -o clients/java
	# npx openapi-generator-cli generate -i clients/openapi.json -g python -o clients/python
	# npx openapi-generator-cli generate -i clients/openapi.json -g rust -o clients/rust
	killall python
