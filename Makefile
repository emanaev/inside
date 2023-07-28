run:
	./run.sh
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
	docker save mon -o mon.tar
	rm tmp
	ln -s /var/run tmp

release:
	tar -cvzf monitoring.tar.gz mon.tar tmp run.sh
