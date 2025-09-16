
## Testing Queries

java -jar stilts.jar tapquery sync=false tapurl="http://35.192.145.251/tap" adql="SELECT diaObjectId, ra, dec FROM ppdb.DiaObject WHERE CONTAINS(POINT('ICRS', ra, dec), CIRCLE('ICRS', 186.8, 7.0, 0.1)) = 1"


