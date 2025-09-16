# tap bigquery

## Build commands

```
cd cadc-tap-server-bigquery &&  ../gradlew --info clean build
cd tap-service-bigquery &&  ../gradlew --info clean build
```

## Build container

```
cd tap-service-bigquery
skaffold build
````

Build and deploy with `skaffold run`

## Deploy container

```
cd tap-service-bigquery
skaffold deploy
```

