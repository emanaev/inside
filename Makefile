run:
	docker run -p 8880:80 -d --restart=always --name mon -v /var/run:/tmp/var/run mon
	docker logs mon
ssh:
	ssh -p 9992 root@localhost
logs:
	docker logs mon
stop:
	docker stop mon
	docker rm mon
build:
	docker build -t mon .

release:
	docker save mon -o mon.tar

