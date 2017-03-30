
build:
	docker build -t jryans/debugger-gecko .

publish:
	docker push jryans/debugger-gecko
