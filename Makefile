postgres:
	docker run --name postgres15.3 -p 5411:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:15.3-alpine

createdb:
	docker exec -it postgres15.3 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres15.3 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5411/simple_bank?sslmode=disable" --verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5411/simple_bank?sslmode=disable" --verbose down

sqlc:
	sqlc generate
test:
	go test -v -cover -short ./...
server: go run main.go
.PHONY: postgres createdb dropdb migrateup migratedown sqlc test server