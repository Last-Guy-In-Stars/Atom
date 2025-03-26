##############################################################
##############################################################
sqlite3 .config/chromium/Default/History
.tables
SELECT * FROM downloads;
SELECT * FROM urls;
sqlite3 .mozilla/firefox/psvd2vxp.default-release/places.sqlite
.tables
SELECT * FROM moz_annos;
SELECT * FROM moz_places;